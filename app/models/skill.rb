class Skill < ApplicationRecord
  has_many :worker_skills, dependent: :destroy
  has_many :workers , through: :worker_skills
  accepts_nested_attributes_for :worker_skills
end
