class WorkerSkill < ApplicationRecord
  belongs_to :worker
  belongs_to :skill
  accepts_nested_attributes_for :skill
end
