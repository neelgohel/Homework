class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :bookings,dependent: :destroy

  validates :first_name,presence:true
  validates :last_name,presence:true
  validates :phone_number,presence:true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/,
    message: "Please Enter valid email address" }
  validates_uniqueness_of :phone_number
  validate :phone_number_length?

  private
  def phone_number_length?
    if phone_number?
      if phone_number.length != 10
        errors.add(:phone_number,":length should be 10.")
        false
      end
    end
  end

end
