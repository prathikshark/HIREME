FactoryBot.define do
  factory :booking do
    booked { true }
    association :customer, factory: [:customer, :booking]
  end
end