class AddColumnsToWorker < ActiveRecord::Migration[7.1]
  def change
    add_column :workers, :status, :string, default: 'pending'
    add_column :workers, :educational_qualification, :string
    add_column :workers, :marital_status, :string
    add_column :workers, :language, :text
    add_column :workers, :shift, :string
    add_column :workers, :date_of_birth, :date
  end
end
