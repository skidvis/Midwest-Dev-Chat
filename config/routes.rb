Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  get 'home/index'

  root 'home#index'

  post '/create' => 'home#create', :as => :create
  get '/home/index/:slack_id', to: 'home#index'
  get '/success' => 'home#success', :as => :success
  resources :careers, :only => [:index]
  get '/careers/all_devs' => 'careers#all_devs'

end
