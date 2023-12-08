Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
# config/routes.rb
namespace :api do
  namespace :v0 do
    get "/markets/search", to: "markets_search#index"
    delete "/market_vendors", to: "market_vendors#destroy"
    
    resources :markets, only: [:index, :show] do
      resources :vendors, only: [:index], controller: 'markets/vendors'
      resources :nearest_atms, only: [:index], controller: 'markets/nearest_atms'
    end
    resources :vendors
    resources :market_vendors, only: [:create]
  end
end

end
