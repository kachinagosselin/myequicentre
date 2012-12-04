Railsapp::Application.routes.draw do
    ## For the auth
    authenticated :user do
        root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users
  
    ## Object resources
    resources :users do
        resources :horses
        resources :messages
        end
    
    resources :posts do
        resources :comments
        end
            
    match ':controller(/:action(/:id(.:format)))' => ':controller#:action', :via => [:get]
    #match 'horses/search(/:id)' => 'horses#search', :via => [:get]
    #match 'horses(/:id)/search' => 'horses#search', :via => [:get]
    match 'horses' => 'home#index', :via => [:get]

    get "/pages/about"
    get "/pages/info"
      
    get "/pages/guidelines"
    get "/pages/terms"
    get "/pages/privacy"

    get "/pages/press"
    get "/pages/contact"

    get "/pages/stories"
    get "/pages/jobs"
    
    get "/pages/sample_search"
    get "/pages/sample_create_form"
    
    get "/messages/drafts"
    match '/users/:user_id/dashboard', :controller => 'users', :action => 'dashboard'

    match '/messages/inbox', :controller => 'messages', :action => 'inbox'
    match '/users/:user_id/messages/:id/draft', :controller => 'messages', :action => 'drafts'
    match '/messages/sent', :controller => 'messages', :action => 'sent'
    match '/messages/archive', :controller => 'messages', :action => 'archive'
    match '/messages/trash', :controller => 'messages', :action => 'trash'

end