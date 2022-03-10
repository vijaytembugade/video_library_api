class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound do |exception|
   render json: { message: exception.message , status: :not_found }, status: :not_found
  end

end
