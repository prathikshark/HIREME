FactoryBot.define do
    factory :worker_skill do 
        experience {"1 year "}
        wage {300}
        rating {0.0}
        worker_id {build(:worker).id}
        skill_id {build(:skill).id}
    end
end