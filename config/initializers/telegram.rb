Rails.application.configure do
  TELEGRAM_BOT_TOKEN = ENV.fetch("TELEGRAM_BOT_TOKEN") if !Rails.env.test?
  TELEGRAM_CHAT_ID   = ENV.fetch("TELEGRAM_CHAT_ID") if !Rails.env.test?
end