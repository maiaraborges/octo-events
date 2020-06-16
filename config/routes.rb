Rails.application.routes.draw do
  get "/events", to:'events#index'
  post "/events", to:'events#create'
  get "/events/:number", to:'events#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
