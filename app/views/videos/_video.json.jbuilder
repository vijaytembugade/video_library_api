json.extract! video, :id, :title, :category, :url, :thumbnail, :channelName, :description, :created_at, :updated_at
json.url video_url(video, format: :json)
