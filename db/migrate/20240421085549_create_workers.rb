class CreateWorkers < ActiveRecord::Migration[7.1]
  def change
    create_table :workers do |t|
      t.string :SSnumber
      t.string :gender
      t.integer :age
      t.string :profile_picture
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
