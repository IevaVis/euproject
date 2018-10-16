Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  resources :documents
  resources :diyprojects

  resources :chatrooms do
    resources :comments, only: [:create, :destroy]
  end

  resources :conversations do
    resources :messages
  end
  
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create, :destroy]

  resources :users, controller: "users" do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


  
