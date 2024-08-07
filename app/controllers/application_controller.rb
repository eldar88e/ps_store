class ApplicationController < ActionController::Base
  include Pagy::Backend

  protect_from_forgery with: :exception
  before_action :set_search

  around_action :switch_locale

  def error_notice(msg)
    render turbo_stream: send_notice(msg, 'danger')
  end

  def success_notice(msg)
    send_notice(msg, 'success')
  end

  private

  def switch_locale(&action)
    locale = locale_from_url || I18n.default_locale
    I18n.with_locale locale, &action
  end

  def locale_from_url
    locale = params[:locale]
    locale if I18n.available_locales.include?(locale&.to_sym)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def send_notice(msg, key)
    turbo_stream.append(:notices, partial: 'notices/notice', locals: { notices: msg, key: key })
  end

  def set_search
    @q = Game.order(:id).ransack(params[:q])
  end

  def set_games
    @games = Game.where(id: cart_items.uniq)
  end

  def set_total_price
    @total_price = @games.reduce(0) { |result, game| result + (game.price * cart_items.count(game.id)) }
  end
end
