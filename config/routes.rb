Rails.application.routes.draw do
  # ==== HELP CENTER ROUTES === #
  get 'help', to: 'help#index'

  get 'help/about', to: 'help#about'
  get 'help/about/whats-this', to: 'help_about#whats_this'
  get 'help/about/contact', to: 'help_about#contact'

  get 'help/contacts', to: 'help#contacts'
  get 'help/contacts/details', to: 'help_contacts#details'
  get 'help/contacts/creating', to: 'help_contacts#creating'
  get 'help/contacts/managing', to: 'help_contacts#managing'

  get 'help/security', to: 'help#security'
  get 'help/security/tech', to: 'help_security#tech'
  get 'help/security/bugs', to: 'help_security#bugs'

  # === ADMIN ROUTES === #
  get 'admin', to: 'admin#index'
  get 'users', to: 'users#index'
  get 'contacts/all', to: 'contacts#show_all'

  # === EXPORTS ROUTES === #
  get 'exports/json', to: 'exports#json'
  get 'exports/xml', to: 'exports#xml'
  get 'exports/vcf/:id', to: 'exports#vcard'

  # === SESSION MANAGEMENT ROUTES === #
  get 'login', to: 'sessions#login'
  post 'login', to: 'sessions#login_attempt'
  get 'logout', to: 'sessions#logout'

  get 'sign-up', to: 'users#new'
  post 'sign-up', to: 'users#create'

  # === ACCOUNT MANAGEMENT ROUTES === #
  get 'dashboard', to: 'sessions#home'
  get 'profile', to: 'sessions#profile'
  get 'settings', to: 'sessions#settings'

  # === OBJECT RESOURCES === #
  resources :contacts

  # === SPECIAL ROUTES === #
  root to: 'dynamic_routes#root'
end
