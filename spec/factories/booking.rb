FactoryBot.define do
  factory :booking do
    booked { false }
    customer_id {build(:customer).id}
  end
end