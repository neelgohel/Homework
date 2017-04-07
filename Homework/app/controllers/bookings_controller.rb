class BookingsController < ApplicationController
  before_action :authenticate_customer!
  before_action :load_cities,only:[:new,:create]
  before_filter :load_booking,only:[:show,:destroy]
  layout 'customers'
  include BookingsHelper


  def index
    redirect_to customers_path
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.customer_id = current_customer.id
    datetime = params[:booking][:datetime].to_datetime
    city = City.find(params[:booking][:city_id])
    cleaners_not_available = booking_in_time_span(city.bookings,datetime).collect { |booking|
                                                            booking.cleaner.id }
    cleaners_in_city = city.cleaners.where.not(id:cleaners_not_available)
    cleaners_available = cleaners_in_city.collect { |cleaner|
      cleaner.id if !booking_in_time_span(cleaner.bookings,datetime).present?
    }
    if cleaners_available.present?
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
  end

  def show
    if @booking.present?
      if @booking.customer == current_customer
        @cleaner = @booking.cleaner
        @city = @booking.city
      else
        flash[:alert] = "Something Went Wrong"
        root_path
      end
    else
      flash[:alert] = "Something Went Wrong"
      root_path
    end
  end

  def destroy
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

  def load_booking
    @booking = Booking.find_by(id:params[:id])
  end

  def load_cities
    @city = City.all
  end
end
