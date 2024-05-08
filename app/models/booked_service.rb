class BookedService < ApplicationRecord
  belongs_to :booking
  belongs_to :worker
end
