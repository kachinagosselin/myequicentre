Railsapp::Application.routes.draw do
    ## For the auth
    authenticated :user do
        root :to => 'home#welcome'
    end
    root :to => "home#index"
    devise_for :users
  
    ## Object resources
    resources :users do
        resources :horses
        end
    resources :messages
    
    resources :posts do
        resources :comments
        end
    
    match 'horse' => 'horses#show', :via => :get
    match 'horses' => 'horses#index', :via => :get
    match 'users/:user_id/horses/new' => 'horses#create', :via => :get
    
    get "static_pages/about"
    get "static_pages/discover"
    get "static_pages/info_create"
  
    get "static_pages/home"
    get "static_pages/help"
    
    get "static_pages/guidelines"
    get "static_pages/terms"
    get "static_pages/privacy"

    get "static_pages/press"
    get "static_pages/contact"

    get "static_pages/team"
    get "static_pages/stories"
    get "static_pages/jobs"
    
    get "static_pages/sample_horse_profile"
    get "static_pages/sample_dashboard"
    get "static_pages/sample_search"
    get "static_pages/sample_create_form"

end