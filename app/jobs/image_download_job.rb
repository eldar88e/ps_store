class ImageDownloadJob < ApplicationJob
  queue_as :default

  def perform(**args)
    count = 0
    games = args[:count] ? Game.order(:id).limit(args[:count]) : Game.order(:id).all
    games.each do |game|
      next if game.image.attached? && game.image.blob.service.exist?(game.image.key)

      url = "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/#{game.nps_id}/0/image"
      sleep rand(0.5..1.5)
      response = Faraday.get(url)
      if response.status != 200
        Rails.logger.error("Status: #{response.status}; Error open img #{url}")
        next
      end

      body = StringIO.new(response.body)
      game.image.attach(io: body, filename: "#{game.nps_id}.jpg")
      count += 1
    end
    TelegramService.new("Saved #{count} img.").report
  end
end
