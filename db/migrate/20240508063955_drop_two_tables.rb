class DropTwoTables < ActiveRecord::Migration[7.1]
  def change
      drop_table :cart_services 
      drop_table :carts 
  end
end
