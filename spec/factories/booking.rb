FactoryBot.define do
  factory :booking do
    booked { true }
    customer_id {build(:customer).id}
  end
end