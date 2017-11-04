module Api
  module V1
    module Auth
      class SessionsController < DeviseTokenAuth::SessionsController
        protected

        def render_create_success
          render json: @resource
        end
      end
    end
  end
end
