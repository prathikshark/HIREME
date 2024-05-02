class Booking < ApplicationRecord
    belongs_to :customer
    has_many :booked_services, dependent: :destroy
end
