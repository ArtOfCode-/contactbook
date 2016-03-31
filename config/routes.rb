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

  get 'admin/notices', to: 'site_notices#index'
  get 'admin/notices/new', to: 'site_notices#new'
  post 'admin/notices/new', to: 'site_notices#create'
  get 'admin/notices/:id/edit', to: 'site_notices#edit'
  put 'admin/notices/:id/edit', to: 'site_notices#update'
  patch 'admin/notices/:id/edit', to: 'site_notices#update'
  delete 'admin/notices/:id', to: 'site_notices#destroy'

  get 'admin/users/:id', to: 'users#admin_options'
  post 'admin/users/:id/edit', to: 'users#admin_edit'
  patch 'admin/users/:id/edit', to: 'users#admin_edit'

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
  get 'users/confirm', to: 'users#confirm'

  # === CONTACTS ROUTES === #
  get 'contacts/encrypt', to: 'contacts#encrypt'
  post 'contacts/encrypt', to: 'contacts#do_encrypt'
  resources :contacts

  # === SPECIAL ROUTES === #
  root to: 'dynamic_routes#root'
end
