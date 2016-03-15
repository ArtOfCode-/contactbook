Rails.application.routes.draw do
  get 'sessions/login'

  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/settings'

  get 'users/sign_up', to: 'users#new'
  post 'users/sign_up', to: 'users#create'

  resources :contacts
end
