require 'rails_helper'

describe Api::V1::ProjectsController do
  include_context 'ability'

  describe 'GET #index' do
    it 'should be success' do
      get :index

      should respond_with :ok
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :index, Project
        reload_ability(ability)
        get :index

        should respond_with :forbidden
      end
    end
  end

  describe 'GET #show' do
    let(:project) { create(:project, user: user) }

    it 'should be success' do
      get :show, params: { id: project.id }

      should respond_with :ok
    end
  end

  describe 'POST #create' do
    let(:params) { attributes_for(:project) }

    it 'should be success' do
      post :create, params: params

      should respond_with :created
    end

    it 'creates a project' do
      expect { post :create, params: params }.to change { Project.count }.by(1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Project).to receive(:save).and_return(false)
      post :create, params: params

      should respond_with :unprocessable_entity
    end

    context 'unauthorized' do
      it 'returns status 403' do
        ability.cannot :create, Project
        reload_ability(ability)
        post :create, params: params

        should respond_with :forbidden
      end
    end
  end

  describe 'PUT #update' do
    let!(:project) { create(:project, user: user) }

    it 'should return status 200' do
      put :update, params: { id: project.id }

      should respond_with :ok
    end

    it 'updates a project' do
      params = attributes_for(:project)
      put :update, params: { id: project.id, **params }

      expect(Project.exists?(title: params[:title])).to be_truthy
    end

    it 'should return 422' do
      put :update, params: { id: project.id, title: '' }

      should respond_with :unprocessable_entity
    end
  end

  describe 'DELETE #destroy' do
    let!(:project) { create(:project, user: user) }

    it 'should be success' do
      delete :destroy, params: { id: project.id }

      should respond_with :ok
    end

    it 'removes a project' do
      expect { delete :destroy, params: { id: project.id } }.to change { Project.count }.by(-1)
    end

    it 'returns status 422' do
      allow_any_instance_of(Project).to receive(:destroy).and_return(false)
      delete :destroy, params: { id: project.id }

      should respond_with :unprocessable_entity
    end
  end
end
