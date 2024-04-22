class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :set_games, only: [:create]
  before_action :set_total_price, only: [:create]

  def new
    @order = Order.new
  end

  def create
    if user_signed_in?
      return redirect_to root_path, flash: { notice: "Корзина пуста" } if cart_items.blank?

      @order = current_user.orders.build(total_amount: @total_price)
      if @order.save
        @games.each do |game|
          @order.order_items.build(product_type: game.class.to_s,
                                   product_id: game.id,
                                   quantity: cart_items.count(game.id),
                                   unit_price: game.price).save
        end
        session[:cart_items] = []
        OrderMailer.order_confirmation(@order, current_user).deliver_now
      else
        render turbo_stream: success_notice("Не удалось отправить заказ")
      end
    else
      # logic for not authorized users
    end

    render turbo_stream: [
      turbo_stream.update(:cart_counter, partial: 'carts/cart_counter'),
      success_notice("Ваш заказ успешно отправлен.")
    ]
  end
end
