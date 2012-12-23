class AddMoreToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :timing, :datetime
    add_column :tasks, :status, :boolean
  end
end
