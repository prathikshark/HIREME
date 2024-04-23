Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'

  devise_for :users
  resources :admins, only: [:index,:new,:create,:edit,:update] 
  get 'admins/list', to: 'admins#admin_list'
  
  resources :workers
  resources :customers
  resources :skills
  resources :worker_skills
 
  get "up" => "rails/health#show", as: :rails_health_check

end
