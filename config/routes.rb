Rails.application.routes.draw do
  mount_devise_token_auth_for User.name, at: 'api/v1/auth', controllers: {
    registrations: 'api/v1/auth/registrations',
    sessions: 'api/v1/auth/sessions'
  }
end
