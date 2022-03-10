class PlaylistsController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_playlist, only: %i[ show edit update destroy ]

  # GET /playlists 
  def index
    @playlists = current_user.playlists.all
  
    if !@playlists.nil? 
      render json: { playlists: @playlists }
    else 
      render json: { status: :unprocessable_entity }
    end
  end

  # GET /playlists/1 
  def show
  end

  # GET /playlists/new
  def new
    @playlist = Playlist.new
  end

  # GET /playlists/1/edit
  def edit
  end

  # POST /playlists or /playlists.json
  def create
    @playlist = current_user.playlists.build(playlist_params)
      if @playlist.save
        render json: { status: :created, playlists: @playlist }
      else
        render json: {error: @playlist.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /playlists/1 or /playlists/1.json
  def update
      if @playlist.update(playlist_params)
        render json: { status: :ok, playlist: @playlist }
      else
        render json: { error: @playlist.errors, status: :unprocessable_entity }
      end
  end

  # DELETE /playlists/1 or /playlists/1.json
  def destroy
    if @playlist.destroy
      render json: { status: :ok, message: 'Playlist Deleted Successfully' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = current_user.playlists.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def playlist_params
      params.require(:playlist).permit(:name, :video_id)
    end
end
