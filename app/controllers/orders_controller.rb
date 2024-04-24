class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :set_games, only: [:create]
  before_action :set_total_price, only: [:create]

  def new
    @order = Order.new
  end

  def create
    user = user_signed_in? ? current_user : User.from_email(order_params)
    return redirect_to root_path, flash: { notice: "Корзина пуста" } if cart_items.blank?

    @order = user.orders.build(total_amount: @total_price, privacy: params[:order][:privacy],
                               address: params[:order][:address])
    if @order.save
      @games.each do |game|
        @order.order_items.build(product_type: game.class.to_s,
                                 product_id: game.id,
                                 quantity: cart_items.count(game.id),
                                 unit_price: game.price).save
      end
      session[:cart_items] = []
      OrderMailer.order_confirmation(@order, user).deliver_now
      redirect_to root_path, notice: 'Ваш заказ успешно отправлен.'
    else
      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:full_name, :email, :phone, :address, :comments, :privacy)
  end
end
