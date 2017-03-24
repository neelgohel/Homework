class City < ApplicationRecord
  has_and_belongs_to_many :cleaners,dependent: :destroy
  has_many :bookings,dependent: :destroy

  validates :city_name,presence:true
  validates_uniqueness_of :city_name
end
