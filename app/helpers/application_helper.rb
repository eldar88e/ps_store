module ApplicationHelper
  def cart_items
    session[:cart_items] ||= []
  end
end
