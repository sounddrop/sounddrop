Rails.application.routes.draw do

  get "/404", to: "errors#error_404"
  get "/500", to: "errors#error_500"

  root 'welcome#index'

  get 'welcome/index'
  get 'welcome/about'
  get 'my_drops', to: 'user_drops#index', as: :my_drops_user
  get 'explorer', to: 'explorer#show'

  resources :drops do
    member do
      post 'upvote'
    end
  end

  namespace :api do
    resources :drops, defaults: { format: 'json' }, only: [:index]
  end

  get '/stats' => 'charts#stats', :as => 'stats'
  get '/charts' => 'charts#charts', :as => 'charts_json'
  get '/login' => 'connect#login'
  get '/login_message' => 'connect#login_message'
  get '/verify' => 'connect#verify'
end
