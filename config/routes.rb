Railsapp::Application.routes.draw do
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


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users

end