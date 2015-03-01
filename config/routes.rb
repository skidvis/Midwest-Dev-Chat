Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  post '/create' => 'home#create', :as => :create
  get '/home/index/:slack_id', to: 'home#index'

end
