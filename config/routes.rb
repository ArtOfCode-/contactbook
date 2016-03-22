Rails.application.routes.draw do
  get 'help_security/tech'

  get 'help_security/bugs'

  get 'help_about/whats_this'

  get 'help_about/contact'

  get 'help', to: 'help#index'
  get 'help/contacts', to: 'help#contacts'
  get 'help/security', to: 'help#security'

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
