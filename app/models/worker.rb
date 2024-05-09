class Worker < ApplicationRecord
  belongs_to :user, inverse_of: :worker
  has_one_attached :profile_picture
  has_many :worker_skills, dependent: :destroy
  has_many :skills , through: :worker_skills
  has_many :booked_services, dependent: :destroy
  has_many :bookings, through: :booked_services

  validate :ssn_format
  validates :address, presence: true
  validates :gender, presence: true
  validates :age, presence: true
  validates :from_date, presence: true
  validates :to_date, presence: true
  validates :shift, presence: true
  validates :date_of_birth, presence: true

  private
  def ssn_format
    unless ssn =~ /^(?!(000|666|9))\d{3}-?(?!(00))\d{2}-?(?!(0000))\d{4}$/
      errors.add(:ssn, 'must be in the format XXX-XX-XXXX and not start with 000, 666, or 9')
    end
  end

end
