Rails.application.routes.draw do
  get 'home/index'

  root 'home#index'

  post "/create" => "home#create", :as => :create
end
