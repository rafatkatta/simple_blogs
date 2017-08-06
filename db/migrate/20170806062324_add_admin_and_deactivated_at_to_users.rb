class AddAdminAndDeactivatedAtToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :deactivate_at, :datetime
  end
end
