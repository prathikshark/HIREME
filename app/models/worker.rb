class Worker < ApplicationRecord
  belongs_to :user, inverse_of: :worker
  has_one_attached :profile_picture
  has_many :worker_skills, dependent: :destroy
  has_many :skills , through: :worker_skills
  has_many :booked_services, dependent: :destroy
  has_many :bookings, through: :booked_services

  validates :SSnumber, presence: true

  validates :gender, presence: true
  validates :age, presence: true
  validates :from_date, presence: true
  validates :to_date, presence: true
  validates :shift, presence: true
  validates :date_of_birth, presence: true

end
