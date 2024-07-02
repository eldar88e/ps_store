require 'telegram/bot'

class TelegramService
  def initialize(message)
    @message = message
    @chat_id = TELEGRAM_CHAT_ID # Setting.pluck(:var, :value).to_h['telegram_chat_id']
  end
  def report
    unless @message.present?
      log 'An empty message has been sent to Telegram!', :red
      return
    end

    tg_send
  end

  private

  def tg_send
    [@chat_id.to_s.split(',')].flatten.each do |user_id|
      message_limit = 4000
      message_count = @message.size / message_limit + 1
      Telegram::Bot::Client.run(TELEGRAM_BOT_TOKEN) do |bot|
        message_count.times do
          splitted_text = @message.chars
          text_part     = splitted_text.shift(message_limit).join
          bot.api.send_message(chat_id: user_id, text: escape(text_part), parse_mode: 'MarkdownV2')
        end
      rescue => e
        Rails.logger.error e.message
      end
    end
    nil
  end

  def escape(text)
    text.gsub(/\[.*?m/, '').gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\1')
  end
end
