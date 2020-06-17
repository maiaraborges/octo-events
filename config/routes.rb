Rails.application.routes.draw do
  resource :github_webhooks, only: :create, defaults: { formats: :json }, path: '/events'
  get "/events", to:'events#index'
  get "/issues/:number/events", to:'events#issues'
end
