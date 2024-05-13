FactoryBot.define do
  factory :booking do
    from_date { Date.new(2024, 10, 31) }
    to_date { Date.new(2024, 10, 31) }
    shift {"Day"}
    association :user, factory: [:customer, :booking]
  end
end