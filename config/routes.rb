Railsapp::Application.routes.draw do    
    ## For the auth
    authenticated :user do
        root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users
  
    match '/users/:user_id/messages/inbox(/:id(.:format))', :controller => 'messages', :action => 'inbox', :via => [:get], :as => 'user_messages_inbox'
    match '/users/:user_id/messages/drafts(/:id(.:format))', :controller => 'messages', :action => 'draft', :via => [:get], :as => 'user_messages_drafts'
    match '/users/:user_id/messages/sent(/:id(.:format))', :controller => 'messages', :action => 'sent', :via => [:get], :as => 'user_messages_sent'
    match '/users/:user_id/messages/archive(/:id(.:format))', :controller => 'messages', :action => 'archive', :via => [:get], :as => 'user_messages_archive'
    match '/users/:user_id/messages/trash(/:id(.:format))', :controller => 'messages', :action => 'trash', :via => [:get], :as => 'user_messages_trash'

    ## Object resources
    resources :users do
        resources :horses 
        resources :messages
        end
    
    resources :posts do
        resources :comments
        end
    
    #match ':controller(/:action(/:id(.:format)))' => ':controller#:action', :via => [:get]
    match 'horses/search(/:id)' => 'horses#search', :via => [:get]
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
    
    match '/users/:user_id/messages/:id/draft', :controller => 'messages', :action => 'drafts'
    match '/messages/sent', :controller => 'messages', :action => 'sent'
    
end