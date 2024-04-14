class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :middle_name
      t.string :email
      t.string :phone, limit: 10
      t.boolean :account
      t.string :login_account
      t.string :pass_account
      t.string :country_account
      t.string :remote_ip

      t.timestamps
    end
  end
end
