class OrdersController < ApplicationController
  include ApplicationHelper

  def new
    @order = Order.new
  end

  def create
    render turbo_stream: [
      success_notice("Ваш заказ успешно отправлен.")
    ]
  end
end
