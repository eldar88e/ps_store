class JobsController < ApplicationController
  before_action :authenticate_user!

  def index; end

  def download_img
    ImageDownloadJob.perform_later  #(count: 10)
    render turbo_stream: [success_notice('Задача успешно поставленна в очередь.')]
  end
end
