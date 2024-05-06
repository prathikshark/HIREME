class Skill < ApplicationRecord
  has_many :worker_skills,dependent: :destroy
  has_many :workers , through: :workerSkills
  accepts_nested_attributes_for :worker_skills
end
