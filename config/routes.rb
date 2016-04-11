Rails.application.routes.draw do

  get "/404", to: "errors#error_404"
  get "/500", to: "errors#error_500"

  #get 'welcome/index'

  root 'welcome#index'

  get 'welcome/index'
  get 'welcome/scan'

  resources :drops do
    member do
      post 'upvote'
    end
  end

  get '/stats' => 'charts#stats', :as => 'stats'
  get '/charts' => 'charts#charts', :as => 'charts_json'
  get '/login' => 'connect#login'
  get '/login_message' => 'connect#login_message'
  get '/verify' => 'connect#verify'
end
