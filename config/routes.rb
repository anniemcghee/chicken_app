Rails.application.routes.draw do

  get '/' => 'chickens#home'

  resources :chickens

  get 'chickens/tag/:tag' =>"chickens#tag", as: :tag

  resources :tags
  resources :users, :only => [:show]

  get "signup" => "users#new"
  post "signup" => "users#create"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  post "logout" => "sessions#destroy"


  get "*path", to: "application#not_found"
  # the above route needs to be LAST. It is an error route that
  #uses "Not found" method that was defined in our application controller.
  #It will handle all bad urls that don't have to do with find_by_id params.


end
