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

  def mail_cleaner_cancel(cleaner,customer,city)

    @cleaner = cleaner
    @customer = customer
    @city = city
    mail(to: @cleaner.email, subject: "Cleaning Order Cancelled at #{@city.city_name}")
  end
end
