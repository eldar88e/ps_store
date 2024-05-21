class GamesController < ApplicationController
  after_action :store_history, only: :show
  before_action :set_game, only: :show

  # @route GET (/:locale)/games (games)
  # @route GET /(:locale) (root)
  def index
    @games = @q.result.page(params[:page]).per(36)

    respond_to do |format|
      format.html
      format.json { render json: @games }
    end
  end

  # @route GET (/:locale)/games/:id (game)
  def show; end

  private

  def set_game
    @game = Game.find(params[:id].to_i)
  end

  def store_history
    session[:history] ||= []
    session[:history].delete_at(0) if session[:history].size > 4
    session[:history] << @game.id unless session[:history].include?(@game.id)
    session[:history].delete_at(0) if session[:history].size > 4
  end
end
