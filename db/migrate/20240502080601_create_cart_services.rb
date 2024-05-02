class CreateCartServices < ActiveRecord::Migration[7.1]
  def change
    create_table :cart_services do |t|
      t.references :cart, null: false, foreign_key: true
      t.integer :worker_id
      t.date :from_date
      t.date :to_date
      t.string :skill_type
      t.string :shift
      t.string :time
      t.integer :hour_per_day
      t.integer :wage

      t.timestamps
    end
  end
end
