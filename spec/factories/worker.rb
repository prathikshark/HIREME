FactoryBot.define do
    factory :worker do 
        SSnumber {"123121212"}
        gender {"Female"}
        age {21}
        from_date {"31-10-2024"}
        to_date {"11-11-2024"}
        shift {"Day"}
        user_id {build(:user).id}
    end
end