class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :name
      t.string :ps_id
      t.float  :price
      t.float  :old_price
      t.float  :bonus_price
      t.date   :date_discount_price
      t.text   :content
      t.string :img
      t.string :platform
      t.string :md5_hash
      t.boolean :deleted
      t.integer     :run_id
      t.integer :touched_run_id

      t.timestamps
    end
  end
end
