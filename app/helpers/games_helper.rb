module GamesHelper
  def recently
    Game.where(id: [session[:history]].flatten)
  end

  def storage_img(game, type)
    size = { large: 1024, medium: 636, small: 346, thumb: 100 }
    if game.image.attached? && game.image.variant(type)
      url_for(game.image.variant(type))
    else
      "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/#{game.nps_id}/0/image?w=#{size[type]}&h=#{size[type]}"
    end
  end
end
