class OrderMailer < ApplicationMailer
  include Rails.application.routes.url_helpers

  def order_confirmation(order, current_user)
    @order = order
    @current_user = current_user
    mail(to: @order.user.email, subject: 'Подтверждение заказа')
  end
end
