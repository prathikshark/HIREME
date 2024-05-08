class Worker < ApplicationRecord
  belongs_to :user, inverse_of: :worker
  has_one_attached :profile_picture
  has_many :worker_skills, dependent: :destroy
  has_many :skills , through: :worker_skills
  has_many :booked_services, dependent: :destroy
  has_many :bookings, through: :booked_services
end
