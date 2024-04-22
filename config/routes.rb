Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'

  devise_for :users
  resources :admins, only: [:index]  
  get 'admins/all', to: 'admins#all'
  

 
  get "up" => "rails/health#show", as: :rails_health_check

end
