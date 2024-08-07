class FavoritesController < ApplicationController
  include ApplicationHelper

  # @route GET (/:locale)/favorites (favorites)
  def index
    @pagy, @favorites = pagy(Game.where(id: favorites))
  end

  # @route POST (/:locale)/favorites (favorites)
  def create
    if user_signed_in?
      favorite = current_user.favorites.find_by(game_id: params[:id])
      if favorite
        favorite.destroy
        msg = "Товар #{ params[:game]} был успешно удален из избранных."
      else
        favorite = current_user.favorites.build(game_id: params[:id])
        if favorite.save
          msg = "Товар #{ params[:game]} был успешно добавлен в избранное."
        else
          return error_notice(favorite.errors.full_messages)
        end
      end
    else
      if favorites.include?(params[:id].to_i)
        favorites.delete params[:id].to_i
        msg = "Товар #{ params[:game]} был успешно удален из избранных."
      else
        favorites << params[:id].to_i
        msg = "Товар #{ params[:game]} был успешно добавлен в избранное."
      end
    end
    render turbo_stream: [
      success_notice(msg),
      turbo_stream.update(:favorite_counter, partial: 'favorites/favorite_counter'),
      turbo_stream.update("game-#{params[:id]}", partial: 'favorites/add_favorite',
                           locals: { id: params[:id].to_i, name: params[:game] })
    ]
  end
end
