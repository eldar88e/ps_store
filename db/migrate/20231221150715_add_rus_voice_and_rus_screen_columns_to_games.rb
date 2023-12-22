class AddRusVoiceAndRusScreenColumnsToGames < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :rus_voice, :boolean
    add_column :games, :rus_screen, :boolean
  end
end
