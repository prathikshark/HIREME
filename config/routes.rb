Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'
  get 'portal', to: 'pages#portal'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
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
  resources :bookings do
    member do
        patch 'reject'
        patch 'approve'
        patch 'update_booked'
      end
    collection do
        get 'booking_confirmed'
    end    
  end
  resources :booked_services

end