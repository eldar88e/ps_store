module ApplicationHelper
  def cart_items
    session[:cart_items] ||= []
  end

  def favorites
    if user_signed_in?
      current_user.favorites.pluck(:game_id)
    else
      session[:favorites] ||= []
    end
  end
end
