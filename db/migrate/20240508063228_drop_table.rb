class DropTable < ActiveRecord::Migration[7.1]
  def change
        drop_table :unavailabilities 
  end
end
