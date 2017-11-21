require 'rails_helper'

describe Api::V1::TasksController do
  include_context 'ability'

  let!(:project) { create(:project, user: user) }

  describe 'GET #index' do
    it 'should be success' do
      get :index, params: { project_id: project.id }

      should respond_with :ok
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :index, Task
        reload_ability(ability)
        get :index, params: { project_id: project.id }

        should respond_with :forbidden
      end
    end
  end

  describe 'GET #show' do
    let(:task) { create(:task, project: project) }

    it 'should be success' do
      get :show, params: { project_id: project.id, id: task.id }

      should respond_with :ok
    end
  end

  describe 'POST #create' do
    let(:task_params) { attributes_for(:task, project: project) }
    let(:params) do
      {
        project_id: project.id,
        **task_params
      }
    end

    it 'should be success' do
      post :create, params: params

      should respond_with :created
    end

    it 'creates a task' do
      expect { post :create, params: params }.to change { Task.count }.by(1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Task).to receive(:save).and_return(false)
      post :create, params: params

      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :create, Task
        reload_ability(ability)
        post :create, params: params

        should respond_with :forbidden
      end
    end
  end

  describe 'PUT #update' do
    let!(:task) { create(:task, project: project) }

    it 'should return status 200' do
      put :update, params: { project_id: project.id, id: task.id }

      should respond_with :ok
    end

    it 'updates a project' do
      params = attributes_for(:task, project: project)
      put :update, params: { project_id: project.id, id: task.id, **params }

      expect(Task.exists?(title: params[:title])).to be_truthy
    end

    it 'should return 422' do
      put :update, params: { project_id: project.id, id: task.id, title: '' }

      should respond_with :unprocessable_entity
    end
  end

  describe 'DELETE #destroy' do
    let!(:task) { create(:task, project: project) }
    let(:params) do
      {
        project_id: project.id, id: task.id
      }
    end

    it 'should be success' do
      delete :destroy, params: params

      should respond_with :ok
    end

    it 'removes a task' do
      expect { delete :destroy, params: params }.to change { Task.count }.by(-1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Task).to receive(:destroy).and_return(false)
      delete :destroy, params: params

      should respond_with :unprocessable_entity
    end
  end
end
