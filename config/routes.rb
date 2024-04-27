Rails.application.routes.draw do
  root 'pages#home'
  get 'aboutus', to: 'pages#aboutus'
  get 'contactus', to: 'pages#contactus'
  get 'portal', to: 'pages#portal'

  devise_for :users

  resources :admins, only: [:index,:new,:create,:edit,:update] 
  get 'admins/list', to: 'admins#admin_list'
  
  get 'workers/by_skill', to: 'workers#by_skill', as: 'workers_by_skill'
  resources :workers, only: [:index, :new, :create, :edit, :update, :show]

  resources :customers
  resources :skills
  resources :worker_skills
 

end
