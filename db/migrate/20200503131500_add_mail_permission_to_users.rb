class AddMailPermissionToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mail_permission, :boolean, null: false, default: true
  end
end
