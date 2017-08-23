Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'registrations', 
    omniauth_callbacks: 'users/omniauth_callbacks' } do
    get '/users/sign_out' => 'devise/sessions#destroy' 
  end

  namespace :api, defaults: { format: :json } do
    scope module: :v1 do
      resources :devs, only: [:index]
      resources :jobs, only: [:index]
    end
  end

  get 'home/index'
  root 'home#index'

  post '/create' => 'home#create', :as => :create
  get '/home/index/:slack_id', to: 'home#index'
  get '/success' => 'home#success', :as => :success  
  get '/careers/' => 'careers#index'
  get '/careers/all_devs' => 'careers#all_devs'
  get '/careers/all_jobs' => 'careers#all_jobs'
  get '/careers/manage' => 'careers#manage'
  resources :jobs

end
