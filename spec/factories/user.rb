FactoryBot.define do
  factory :user do
    name { "Aman" }
    address { "marathalli" }
    phone { "1234567819" }
    email { "aman@gmail.com" } 
    password { "password123" } 

    trait :worker do
      role { "worker" }
    end

    trait :customer do
      role { "customer" }
    end

  end
end
