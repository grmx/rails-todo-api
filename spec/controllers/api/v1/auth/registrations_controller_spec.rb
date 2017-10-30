require 'rails_helper'

describe Api::V1::Auth::RegistrationsController do
  let(:user) { create(:user) }

  before { @request.env['devise.mapping'] = Devise.mappings[:user] }

  describe 'POST #create' do
    let(:params) do
      {
        email: Faker::Internet.email,
        password: Faker::Internet.password
      }
    end

    it 'returns 201' do
      post :create, params: params

      should respond_with :created
    end

    it 'creates a new user' do
      expect { post :create, params: params }.to change { User.count }.by(1)
    end

    context 'email already in use' do
      it 'returns 403' do
        create(:user, email: params[:email])
        params[:password] = nil
        post :create, params: params

        should respond_with :forbidden
      end

      it 'does not create a new user' do
        expect { post :create, params: params }.to change { User.count }.by(1)
      end
    end
  end
end
