Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'
  get 'portal', to: 'pages#portal'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  get 'admins/list', to: 'admins#admin_list'
  resources :admins


  post 'workers/filter', to: 'workers#filter'
  
  resources :workers do
    member do
       patch 'reject'
       patch 'approve'
       patch 'update_status'
    end
   end
   
  resources :customers
  resources :skills
  resources :worker_skills
  resources :carts
  resources :cart_services
  resources :bookings
  resources :booked_services

end