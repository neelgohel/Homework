class City < ApplicationRecord
  has_and_belongs_to_many :cleaners
  validates :city_name,presence:true
  validates_uniqueness_of :city_name
end
