class BookingsController < ApplicationController
    before_action :authenticate_customer!
    layout 'customers'

  def index
    redirect_to customers_path
  end

  def new
    @city = City.all
    @booking = Booking.new
  end

  def create
    @city = City.all
    @booking = Booking.new(booking_params)
    @booking.customer_id = current_customer.id
    begin
      datetime = DateTime.new(params[:booking]["datetime(1i)"].to_i, params[:booking]["datetime(2i)"].to_i,
                          params[:booking]["datetime(3i)"].to_i, params[:booking]["datetime(4i)"].to_i,
                          params[:booking]["datetime(5i)"].to_i,0,'+05:30')
      city = City.find(params[:booking][:city_id])
      city_bookings_at_same_time = city.bookings.where(datetime:((datetime-2.hours)..(datetime+2.hours)))
      cleaners_not_available = []
      city_bookings_at_same_time.each do |booking|
        cleaners_not_available.push(booking.cleaner.id)
      end
      cleaners_in_city = city.cleaners.where.not(id:cleaners_not_available)
      cleaners_available = []
      cleaners_in_city.each do |cleaner|
        if cleaner.bookings.where(datetime:((datetime-2.hours)..(datetime+2.hours))) == []
          cleaners_available.push(cleaner.id)
        end
      end
      if cleaners_available != []
      @booking.cleaner_id = cleaners_available.sample
      if @booking.save
        BookingmailMailer.mail_cleaner(@booking.id).deliver_later
        redirect_to @booking
      else
        render 'new'
      end
      else
        flash[:alert] = "No cleaner available at given time.."
        redirect_to new_booking_path
      end
    rescue
      flash[:alert] = "Invalid Date."
      redirect_to new_booking_path
    end
  end

  def show
    @booking = Booking.find_by(id:params[:id])
    unless @booking.nil?
      if @booking.customer == current_customer
        @cleaner = @booking.cleaner
        @city = @booking.city
      else
        redirect_to '/404'
      end
    else
      redirect_to '/404'
    end
  end

  def edit
    redirect_to customers_path
  end

  def destroy
    @booking = Booking.find(params[:id])
    @cleaner = @booking.cleaner
    @city = @booking.city
    @customer = @booking.customer
    if @booking.destroy
      BookingmailMailer.mail_cleaner_cancel(@cleaner,@customer,@city).deliver_later
      redirect_to customers_path
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:datetime, :city_id)
  end
end
