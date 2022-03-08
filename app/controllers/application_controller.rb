class ApplicationController < ActionController::Base

  include JWTSessions::RailsAuthorization
  rescue_from JWTSessions::Errors::Unauthorized , with: :not_authorized

  rescue_from ActiveRecord::RecordNotFound do |exception|
   render json: { message: exception.message , status: :not_found }, status: :not_found
  end

  


  private 

  def current_user  
    @current_user ||= User.find(payload['user_id'])
  end
  
  def not_authorized
    render json: {error: "Not Authorized" }, status: :unauthorized
  end
end
