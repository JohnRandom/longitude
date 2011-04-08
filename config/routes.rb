Longitude::Application.routes.draw do
  # named routes
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  get "documentation" => "statics#documentation", :as => "documentation"


  # REST resources
  resources :users
  resources :sessions

  resources :routes do
    resources :locations, :via => [:get, :post, :delete]
  end

  root :controller => "statics", :action => "start"
end
