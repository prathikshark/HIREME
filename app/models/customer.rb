class Customer < ApplicationRecord
  belongs_to :user
  has_one :cart ,dependent: :destroy
  has_many :bookings ,dependent: :destroy
end
