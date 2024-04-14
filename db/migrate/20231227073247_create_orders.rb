class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :client, foreign_key: true
      t.string :status
      t.decimal :total_amount, precision: 10, scale: 2
      t.timestamps
    end
  end
end
