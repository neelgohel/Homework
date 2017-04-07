class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :cleaner
  belongs_to :city

  validates :cleaner_id,presence:true
  validates :customer_id,presence:true
  validates :city_id,presence:true
  validates :datetime,presence:true
  validate :datetime_of_booking?

  def datetime_of_booking?
    if datetime < Time.now
      errors.add(:time,"Please choose proper time")
      false
    end
  end
end
