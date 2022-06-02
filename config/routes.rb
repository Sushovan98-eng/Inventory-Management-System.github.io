Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "app_interface#index"

  get "dashboard", to: "app_interface#dashboard"
  get "admin_panel", to: "app_interface#admin_panel"
  
    
  get "sign_up", to: "users#new"
  post "sign_up", to: "users#create"

  get "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"

  get "password", to: "users#edit", as: :edit_password
  patch "password", to: "users#update"

  delete "logout", to: "sessions#destroy"

  get "password/reset", to: "password_resets#new"
  post "password/reset", to: "password_resets#create"

  get "password/reset/edit", to: "password_resets#edit"
  patch "password/reset/edit", to: "password_resets#update"

  resources :allotments do
    member do
      get :deallot
      get :users
      get :all_current_allotment
    end
  end

  resources :brands
  
  resources :categories

  resources :items do
    member do
      get :item_allotments
      get :new_stock
      patch :increase_stock
      get :new_allotment
      post :create_allotment
    end
  end
  
  resources :issues do
    member do
      get :solve_issue
      patch :mark_as_solved
    end
  end

  resources :users do
    member do
      get :current_allotment
      patch :make_admin_user
      patch :remove_admin_user
    end
  end
  
end

