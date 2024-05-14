FactoryBot.define do
  factory :user do
    name {  Faker::Company.name  }
    email {Faker::Internet.email}
    address { "marathalli" }
    phone { "1234567819" }
    password { "password123" } 

    trait :worker do
      role { "worker" }
    end

    trait :customer do
      role { "customer" }
    end

  end
end
