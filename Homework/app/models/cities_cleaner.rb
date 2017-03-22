class CitiesCleaner < ApplicationRecord
  belongs_to :city
  belongs_to :cleaner

  validates :cleaner_id,presence:true
  validates :city_id,presence:true
end
