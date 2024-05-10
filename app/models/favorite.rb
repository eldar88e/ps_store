class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :game_id, uniqueness: { scope: :user_id, message: "уже добавлена в избранное" }
end
