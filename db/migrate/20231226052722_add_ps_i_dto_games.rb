class AddPsIDtoGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :nps_id, :string
  end
end
