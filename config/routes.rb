Rails.application.routes.draw do
  get 'users/sign_up', to: 'users#new'

  resources :contacts
end
