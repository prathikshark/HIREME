Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'
  get 'portal', to: 'pages#portal'

  devise_for :users

  get 'admins/list', to: 'admins#admin_list'
  resources :admins

  get 'workers/by_skill', to: 'workers#by_skill', as: 'workers_by_skill'
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
  resources :booked_services, only: [:edit, :update]






 

end