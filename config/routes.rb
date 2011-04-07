Longitude::Application.routes.draw do
  # named routes
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"


  # REST resources
  resources :routes
  resources :users
  resources :sessions

  resources :routes do
    resources :locations
  end

  root :controller => "statics", :action => "start"
end
