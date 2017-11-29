module Api
  module V1
    class CommentsController < ApiController
      load_and_authorize_resource :task
      load_and_authorize_resource :comment, through: :task, shallow: true

      def index
        render json: @comments
      end

      def show
        render json: @comment
      end

      def create
        if @comment.save
          render json: @comment, status: :created
        else
          render json: @comment.errors.messages, status: :unprocessable_entity
        end
      end

      def update
        if @comment.update(comment_params)
          render json: @comment, status: :ok
        else
          render json: @comment.errors.messages, status: :unprocessable_entity
        end
      end

      def destroy
        if @comment.destroy
          render json: @comment, status: :ok
        else
          render json: @comment.errors.messages, status: :unprocessable_entity
        end
      end

      private

      def comment_params
        params.permit(:body)
      end
    end
  end
end
