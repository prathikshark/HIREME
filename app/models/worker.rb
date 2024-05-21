class Worker < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_one_attached :profile_picture
  has_many :worker_skills, dependent: :destroy
  has_many :skills , through: :worker_skills
  has_many :booked_services, dependent: :destroy
  has_many :bookings, through: :booked_services

  validates :SSnumber, numericality: { only_integer: true }, format: { with: /\A\d{9}\z/, message: "SSnumber number must be a 9-digit number" }
end
