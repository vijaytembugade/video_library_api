class SigninController < ApplicationController
  before_action :authorize_access_request! , only: [:destroy]


  def create
    user = User.find_by(email: params[:email])
    payload = {user_id: user.id }

    if user.authenticate(params[:password])
      session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)

      tokens = session.login
      response.set_cookie(JWTSessions.access_cookie, value: tokens[:access], httponly: true, secure: Rails.env.production?)

      render json: {csrf: tokens[:csrf] , user_id: user.id}
    else
      not_authorized
    end
  end


  def destroy
    session = JWTSessions::Session.new(refresh_by_access_allowed: true)
    tokens = session.login
    session.flush_by_access_payload

    
    render json: :ok
  end

  private 

    def not_authorized
      render json: {error: "Invalid Credentials"}, status: :not_found
    end

    
end