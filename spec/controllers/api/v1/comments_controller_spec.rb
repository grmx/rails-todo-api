require 'rails_helper'

describe Api::V1::CommentsController do
  include_context 'ability'

  let(:project) { create(:project, user: user) }
  let!(:task) { create(:task, project: project) }

  describe 'GET #index' do
    it 'should be success' do
      get :index, params: { task_id: task.id }

      should respond_with :ok
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :index, Comment
        reload_ability(ability)
        get :index, params: { task_id: task.id }

        should respond_with :forbidden
      end
    end
  end

  describe 'GET #show' do
    let(:comment) { create(:comment, task: task) }

    it 'should be success' do
      get :show, params: { id: comment.id }

      should respond_with :ok
    end
  end

  describe 'POST #create' do
    let(:comment_params) { attributes_for(:comment, task: task) }
    let(:params) do
      {
        task_id: task.id,
        **comment_params
      }
    end

    it 'should be success' do
      post :create, params: params

      should respond_with :created
    end

    it 'creates a task' do
      expect { post :create, params: params }.to change { Comment.count }.by(1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Comment).to receive(:save).and_return(false)
      post :create, params: params

      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :create, Comment
        reload_ability(ability)
        post :create, params: params

        should respond_with :forbidden
      end
    end
  end

  describe 'PUT #update' do
    let!(:comment) { create(:comment, task: task) }

    it 'should return status 200' do
      put :update, params: { id: comment.id }

      should respond_with :ok
    end

    it 'updates a project' do
      params = attributes_for(:comment, task: task)
      put :update, params: { id: comment.id, **params }

      expect(Comment.exists?(body: params[:body])).to be_truthy
    end

    it 'should return 422' do
      put :update, params: { id: comment.id, body: '' }

      should respond_with :unprocessable_entity
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, task: task) }

    it 'should be success' do
      delete :destroy, params: { id: comment.id }

      should respond_with :ok
    end

    it 'removes a task' do
      expect { delete :destroy, params: { id: comment.id } }.to change { Comment.count }.by(-1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: comment.id }

      should respond_with :unprocessable_entity
    end
  end
end
