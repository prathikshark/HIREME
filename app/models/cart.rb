class Cart < ApplicationRecord
  belongs_to :customer
  has_many :cart_services ,dependent: :destroy
end
