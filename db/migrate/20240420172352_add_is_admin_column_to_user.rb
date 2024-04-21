class AddIsAdminColumnToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :isadmin, :boolean, default: false
  end
end
