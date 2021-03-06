Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root "users#home"
  
  get "signup", to: "users#new"
  resources :users, except: [:new]
  
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  
  resources :comments do
    member do
  		post "like", to: "comments#upvote"
  	end
  end
  
  resources :categories, except: [:destroy]

end


