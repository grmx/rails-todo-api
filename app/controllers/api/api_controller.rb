module Api
  class ApiController < ApplicationController
    include DeviseTokenAuth::Concerns::SetUserByToken
    include CanCan::ControllerAdditions

    check_authorization

    rescue_from CanCan::AccessDenied do |exception|
      render json: exception.message, status: :forbidden
    end
  end
end
