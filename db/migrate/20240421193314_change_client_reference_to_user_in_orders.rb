class ChangeClientReferenceToUserInOrders < ActiveRecord::Migration[7.1]
  def change
    remove_reference :orders, :client, foreign_key: true

    rename_column :orders, :client_id, :user_id
    add_reference :orders, :user, foreign_key: true
  end
end
