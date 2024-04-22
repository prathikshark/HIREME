class CreateWorkerSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :worker_skills do |t|
      t.text :experience
      t.integer :wage
      t.float :rating
      t.references :worker, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
