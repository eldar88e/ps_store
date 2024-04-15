class CartsController < ApplicationController
  include ApplicationHelper
  include GamesHelper
  before_action :cart_items, only: [:create, :destroy, :delete_all]

  def index
    @games = Game.where(id: cart_items.uniq)
  end

  def create
    session[:cart_items] << params[:game_id].to_i
    game = Game.find(params[:game_id])

    render turbo_stream: [
      turbo_stream.update(:cart_counter, partial: 'carts/cart_counter'),
      success_notice("Товар #{game.name} был успешно добавлен в корзину.")
    ]
  end

  def update
    if params[:action_cart] == 'up'
      session[:cart_items] << params[:id].to_i
    elsif params[:action_cart] == 'down'
      index = session[:cart_items].index(params[:id].to_i)
      session[:cart_items].delete_at(index)
    end

    redirect_to cart_path
  end

  def destroy
    session[:cart_items].reject! { |num| num == params[:id].to_i }
    game = params[:name]

    msg = "Товар #{game} был успешно удален из корзины."
    render turbo_stream: [ turbo_stream.remove("cart-item-#{params[:id]}"), success_notice(msg)]
  end

  def delete_all
    session[:cart_items] = []

    redirect_to cart_path
  end
end
