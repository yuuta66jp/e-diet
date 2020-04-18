class AddTotalPointToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :total_point, :integer, null: false, default: 0
  end
end
