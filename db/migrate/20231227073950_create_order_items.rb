class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.string :product_type
      t.integer :product_id
      t.integer :quantity
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps
    end

    add_index :order_items, :product_id
    add_index :order_items, :product_type
  end
end
