class Booking < ApplicationRecord
    belongs_to :customer
    has_many :booked_services, dependent: :destroy
    has_many :workers, through: :booked_services
end
