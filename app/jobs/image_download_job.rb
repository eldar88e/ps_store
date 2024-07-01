class ImageDownloadJob < ApplicationJob
  queue_as :default

  def perform(*args)
    Game.all.each do |game|
      next if game.image.attached?

      url = "https://store.playstation.com/store/api/chihiro/00_09_000/container/TR/tr/99/#{game.nps_id}/0/image"
      sleep rand(0.5..2)
      response = Faraday.get(url)
      if response.status != 200
        Rails.logger.error("Error open img #{url}")
        next
      end

      body = StringIO.new(response.body)
      game.image.attach(io: body, filename: "#{game.nps_id}.jpg")
    end
  end
end
