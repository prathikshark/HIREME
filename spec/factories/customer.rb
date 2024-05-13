FactoryBot.define do
    factory :customer do 
        association :user, factory: [:user, :customer]
    end
end