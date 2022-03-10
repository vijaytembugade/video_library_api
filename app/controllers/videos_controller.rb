class VideosController < ApplicationController
  before_action :authenticate_and_set_user, except: [:show, :index, ]
  before_action :set_video, only: %i[edit update show destroy]

  # GET /videos or /videos.json
  def index
    @videos = Video.all
    puts current_user.email

    if @videos 
      render json: { videos: @videos }
    else 
      render json: { status: :unprocessable_entity }
    end
  end

  # GET /videos/1 or /videos/1.json
  def show
    if @video 
      render json: { video: @video , status: :ok }
    else
      render json: {status: :not_found , message: 'Video is Not available'}
    end
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos or /videos.json
  def create
    @video = Video.new(video_params)

    if @video.save!
      render json: { status: :created, video: @video }
    else
      render json: {message: @video.errors, status: :unprocessable_entity}
    end
  end

  # PATCH/PUT /videos/1 or /videos/1.json
  def update
    if @video.update(video_params)
      render json: { status: :ok, video: @video }
    else
      render json: { status: :unprocessable_entity}
    end
  end

  # DELETE /videos/1 or /videos/1.json
  def destroy
    if @video.destroy
      render json: { status: :ok, message: 'Video Deleted Successfully' }
    else
      render json: { status: :unprocessable_entity }
    end
  end

  private

  def set_video
    @video = Video.find(params[:id])
  end
  def video_params
    params.require(:video).permit(:title, :category, :url, :thumbnail, :channelName, :description)
  end
end
