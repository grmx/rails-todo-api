module Api
  module V1
    class TasksController < ApiController
      load_and_authorize_resource

      def index
        render json: @tasks
      end

      def show
        render json: @task
      end

      def create
        if @task.save
          render json: @task, status: :created
        else
          render json: @task.errors.messages, status: :unprocessable_entity
        end
      end

      def update
        if @task.update(task_params)
          render json: @task, status: :ok
        else
          render json: @task.errors.messages, status: :unprocessable_entity
        end
      end

      def destroy
        if @task.destroy
          render json: @task, status: :ok
        else
          render json: @task.errors.messages, status: :unprocessable_entity
        end
      end

      private

      def task_params
        params.permit(:title, :project_id, :position, :done)
      end
    end
  end
end
