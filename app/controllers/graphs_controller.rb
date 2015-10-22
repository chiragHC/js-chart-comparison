class GraphsController < ApplicationController
  def index
  end

  def rgraph
  end

  def fusioncharts
  end

  def upload_and_download
    image_name = "graphs/#{SecureRandom.urlsafe_base64}.png"
    File.open("public/" + image_name, 'wb') do |f|
      f.write(Base64.decode64(params[:image].split(',')[1]))
    end
    render json: {url: image_name}
  rescue => e
    render status: :error, json: e.message
  end
end
