class Cleaner < ApplicationRecord
  has_and_belongs_to_many :cities,dependent: :destroy
  has_many :bookings,dependent: :destroy

  validates :first_name,presence:true
  validates :last_name,presence:true
  validates :quality_score,presence:true
  validates :email,presence:true
  validate :quality_score_range?

  def quality_score_range?
    unless quality_score.nil?
      if quality_score < 0 || quality_score > 5
        errors.add(:quality_score,":Quality score should be between 0 to 5.")
      end
    end
  end

end
