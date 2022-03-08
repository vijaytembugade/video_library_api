class RefreshController < ApplicationController 
  before_action :authorize_refresh_by_access_request!


  def create 
    session = JWTSession::Session.new(payload: claimless_payload, refresh_by_accss_allowed: true)

    tokens = session.refresh_by_access_allowed do 
      raise JWTSessions::Error::Unauthorized , "Invalid Credentials!"
    end

    response.set_coockie(JWTSession.access_cookie, value: tokens[:access], httponly: true, secure: Rails.env.production?)


    render json: {csrf: tokens[:csrf]}
  end
end