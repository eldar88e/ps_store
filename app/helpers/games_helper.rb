module GamesHelper
  def recently
    Game.where(id: [session[:history]].flatten)
  end
end
