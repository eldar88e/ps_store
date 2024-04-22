class RenameColumClientIdToUserIdInOrder < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :client_id, :user_id
  end
end
