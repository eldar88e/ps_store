class CartsController < ApplicationController
  include ApplicationHelper
  include GamesHelper
  before_action :cart_items, only: [:create, :destroy, :delete_all]
  before_action :set_games, only: [:index]
  before_action :set_total_price, only: [:index]

  # @route GET (/:locale)/cart (cart)
  def index; end

  # @route POST (/:locale)/cart (cart)
  def create
    session[:cart_items] << params[:id].to_i
    game = params[:name]

    # cart_items_update = request.path == '/cart' ? [turbo_stream.update('cart_items')] : []

    render turbo_stream: [
      turbo_stream.update(:cart_counter, partial: 'carts/cart_counter'),
      success_notice("Товар #{game} был успешно добавлен в корзину.")
    ] # + cart_items_update
  end

  # @route PATCH (/:locale)/cart/:id (edite_cart_items)
  def update
    if params[:action_cart] == 'up'
      session[:cart_items] << params[:id].to_i
    elsif params[:action_cart] == 'down'
      index = session[:cart_items].index(params[:id].to_i)
      session[:cart_items].delete_at(index)
    end

    redirect_to cart_path
  end

  # @route DELETE (/:locale)/cart/:id (delete_cart_items)
  def destroy
    session[:cart_items].reject! { |num| num == params[:id].to_i }
    game = params[:name]
    set_games
    set_total_price

    msg = "Товар #{game} был успешно удален из корзины."
    render turbo_stream: [
      turbo_stream.remove("cart-item-#{params[:id]}"),
      success_notice(msg),
      turbo_stream.update(:cart_counter, partial: 'carts/cart_counter'),
      turbo_stream.update(:cart_result, partial: 'carts/cart_result', locals: { total_price: @total_price })
    ]
  end

  # @route DELETE (/:locale)/cart/delete_all (cart_delete_all)
  def delete_all
    session[:cart_items] = []
    set_games
    set_total_price

    render turbo_stream: [
      turbo_stream.update(:cart_items),
      turbo_stream.append(:cart_items, '<h3>Ваша корзина пуста!</h3>'),
      success_notice("Корзина была успешно очищена!"),
      turbo_stream.update(:cart_counter, partial: 'carts/cart_counter')
    ]
  end
end
