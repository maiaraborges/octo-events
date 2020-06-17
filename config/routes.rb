Rails.application.routes.draw do
  get "/events", to:'events#index'
  post "/events", to:'events#create'
  get "/issues/:number/events", to:'events#issues'
end
