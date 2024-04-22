class ChangeClientReferenceToUserInOrders < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :orders, :clients

    add_foreign_key :orders, :users
  end
end
