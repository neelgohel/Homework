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
    datetime = Time.local(params[:booking]["datetime(1i)"].to_i, params[:booking]["datetime(2i)"].to_i,
                        params[:booking]["datetime(3i)"].to_i, params[:booking]["datetime(4i)"].to_i,
                        params[:booking]["datetime(5i)"].to_i)
    city = City.find(params[:booking][:city_id])
    city_bookings_at_same_time = city.bookings.where(datetime:datetime)
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
        BookingmailMailer.mail_cleaner(@booking.id).deliver_now
        redirect_to @booking
      else
        render 'new'
      end
    else
      flash[:notice] = "No cleaner available at given time.."
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @cleaner = @booking.cleaner
    @city = @booking.city
  end

  private

  def booking_params
    params.require(:booking).permit(:datetime, :city_id)
  end
end
