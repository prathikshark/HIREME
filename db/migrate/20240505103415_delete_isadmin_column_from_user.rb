class DeleteIsadminColumnFromUser < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :isadmin, :boolean
  end
end
