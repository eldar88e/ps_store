class AddGenreColumnToGame < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :genre, :string
  end
end
