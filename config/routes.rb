Rails.application.routes.draw do
  get 'admin', to: 'admin#index'

  get 'exports/json', to: 'exports#json'
  get 'exports/xml', to: 'exports#xml'

  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#login_attempt'
  get 'logout', to: 'sessions#logout'

  get 'sign-up', to: 'users#new'
  post 'sign-up', to: 'users#create'

  get 'users', to: 'users#index'

  get 'dashboard', to: 'sessions#home'
  get 'profile', to: 'sessions#profile'
  get 'settings', to: 'sessions#settings'

  get 'exports/json', to: 'exports#json'
  get 'exports/xml', to: 'exports#xml'
  get 'exports/vcf/:id', to: 'exports#vcard'

  root to: 'sessions#home'

  get 'contacts/all', to: 'contacts#show_all'
  resources :contacts
end
