module BookingsHelper
  def booking_in_time_span(bookings,datetime)
    bookings.where(datetime:((datetime-2.hours)..(datetime+2.hours)))
  end
end
