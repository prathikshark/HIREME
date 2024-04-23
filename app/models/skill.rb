class Skill < ApplicationRecord
  has_many :worker_skills
  has_many :skills , through: :workerSkill
end
