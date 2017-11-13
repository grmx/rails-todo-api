module Api
  module V1
    class ProjectsController < ApiController
      load_and_authorize_resource

      def index
        render json: @projects
      end

      def show
        render json: @project
      end

      def create
        if @project.save
          render json: @project, status: :created
        else
          render json: @project.errors.messages, status: :unprocessable_entity
        end
      end

      def update
        if @project.update(project_params)
          render json: @project, status: :ok
        else
          render json: @project.errors.messages, status: :unprocessable_entity
        end
      end

      def destroy
        if @project.destroy
          render json: @project, status: :ok
        else
          render json: @project.errors.messages, status: :unprocessable_entity
        end
      end

      private

      def project_params
        params.permit(:title)
      end
    end
  end
end
