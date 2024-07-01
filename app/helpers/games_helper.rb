module GamesHelper
  def recently
    Game.where(id: [session[:history]].flatten)
  end

  def storage_img(game, type)
    size = { thumb: 100, medium: 346, large: 636, full: 1024 }
    if game.image.attached? && game.image.blob.service.exist?(game.image.key)
      url_for(game.image.variant(type))
    else
      "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/#{game.nps_id}/0/image?w=#{size[type]}&h=#{size[type]}"
    end
  end
end
