Rails.application.routes.draw do

  get '/' => 'chickens#home'
  get "signup" => "users#new"
  post "signup" => "users#create"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  get "logout" => "sessions#destroy"
  post "logout" => "sessions#destroy"

  resources :chickens

  get 'chickens/tag/:tag' =>"chickens#tag", as: :tag

  resources :tags
  resources :users, :only => [:show]



  get "*path", to: "application#not_found"


end
