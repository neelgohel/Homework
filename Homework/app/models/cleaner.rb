class Cleaner < ApplicationRecord
  has_and_belongs_to_many :cities,dependent: :destroy
  has_many :bookings,dependent: :destroy

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validates :first_name,presence:true
  validates :last_name,presence:true
  validates :quality_score,presence:true
  validates :email,presence:true
  validates :email, format: { with:EMAIL_REGEX ,
                              message: "Please Enter valid email address" }
  validates :quality_score, numericality: true
  validates :quality_score, inclusion:{in:(0..5)}


end
