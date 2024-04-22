class AddCommentsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :comments, :string
  end
end
