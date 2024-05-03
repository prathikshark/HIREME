class CreateUnavailabilities < ActiveRecord::Migration[7.1]
  def change
    create_table :unavailabilities do |t|
      t.date :unavailable_date
      t.references :worker, null: false, foreign_key: true

      t.timestamps
    end
  end
end
