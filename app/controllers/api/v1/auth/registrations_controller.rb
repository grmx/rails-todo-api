module Api
  module V1
    module Auth
      class RegistrationsController < DeviseTokenAuth::RegistrationsController
        protected

        def render_create_success
          render json: @resource, status: :created
        end

        def render_create_error
          render json: @resource, status: :forbidden
        end

        def render_create_error_email_already_exists
          render json: @response, status: :forbidden
        end
      end
    end
  end
end
