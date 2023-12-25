class GamesController < ApplicationController
  after_action :store_history, only: :show

  def index
    @games = Game.all.limit(36)
  end

  def show
    @game = Game.find(params[:id].to_i)
  end

  private

  def store_history
    session[:history] ||= []
    session[:history].delete_at(0) if session[:history].size > 4
    session[:history] << @game.id unless session[:history].include?(@game.id)
    session[:history].delete_at(0) if session[:history].size > 4
  end
end
