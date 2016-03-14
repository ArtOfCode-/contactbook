Rails.application.routes.draw do
  get 'users/sign_up', to: 'users#new'
  post 'users/sign_up', to: 'users#create'

  resources :contacts
end
