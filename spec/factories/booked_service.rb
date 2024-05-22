FactoryBot.define do
  factory :booked_service do
    from_date {"10-11-2024"}
    to_date {"11-11-2024"}
    shift {"Day"}
    booking_id {build(:booking).id}
    worker_id {build(:worker).id}
  end
end