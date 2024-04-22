class AddFromdateAndTodateToWorker < ActiveRecord::Migration[7.1]
  def change
    add_column :workers, :from_date, :date
    add_column :workers, :to_date, :date
  end
end
