class BookingmailMailer < ApplicationMailer
  default from: 'lmsbotree@gmail.com'
  layout 'mailer'

  def mail_cleaner(booking_id)
    @booking = Booking.find(booking_id)
    @cleaner = @booking.cleaner
    @customer = @booking.customer
    @city = @booking.city
    mail(to: @cleaner.email, subject: "New Cleaning Order at #{@city.city_name}")
  end

end
