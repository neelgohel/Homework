class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings,dependent: :destroy


  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/
  validates :first_name,presence:true
  validates :last_name,presence:true
  validates :phone_number,presence:true
  validates :email, format: { with:EMAIL_REGEX,
    message: "Please Enter valid email address" }
  validates_uniqueness_of :phone_number
  validates :phone_number, numericality: true
  validates :phone_number,  length: { is: 10 }

end
