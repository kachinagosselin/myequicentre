Railsapp::Application.routes.draw do    
    ## For the auth
    authenticated :user do
        root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users
  
    match '/users/:user_id/messages/inbox(/:id(.:format))', :controller => 'messages', :action => 'inbox', :via => [:get], :as => 'user_messages_inbox'
    match '/users/:user_id/messages/drafts(/:id(.:format))', :controller => 'messages', :action => 'drafts', :via => [:get], :as => 'user_messages_drafts'
    match '/users/:user_id/messages/sent(/:id(.:format))', :controller => 'messages', :action => 'sent', :via => [:get], :as => 'user_messages_sent'
    match '/users/:user_id/messages/archive(/:id(.:format))', :controller => 'messages', :action => 'archive', :via => [:get], :as => 'user_messages_archive'
    match '/users/:user_id/messages/trash(/:id(.:format))', :controller => 'messages', :action => 'trash', :via => [:get], :as => 'user_messages_trash'

    match '/users/:user_id/horses/changestatus(/:id(.:format))', :controller => 'horses', :action => 'changestatus', :via => [:post], :as => 'user_horse_changestatus'
    match '/users/:user_id/horses/flagged(/:id(.:format))', :controller => 'horses', :action => 'flag', :via => [:post], :as => 'user_horse_flag'
    match '/users/:id/changestatus(.:format)', :controller => 'users', :action => 'changestatus', :via => [:post], :as => 'user_changestatus'
    match '/users/:user_id/horses/:horse_id/subscriptions/unsubscribe/:id(.:format)', :controller => 'subscriptions', :action => 'unsubscribe', :via => [:get], :as => 'user_horse_unsubscribe'
    
    ## Object resources
    resources :users do
        resources :horses do
            resources :subscriptions
        end
        resources :messages
        resources :saved_horses
        resources :subscriptions
    end
    
    resources :plans
    
    resources :posts do
        resources :comments
        end
    
    #match ':controller(/:action(/:id(.:format)))' => ':controller#:action', :via => [:get]
    match 'horses/search(/:id)' => 'horses#search', :via => [:get]
    #match 'horses(/:id)/search' => 'horses#search', :via => [:get]
    match 'horses' => 'home#index', :via => [:get]

    get "/pages/about"
    get "/pages/info"
    get "/pages/help"
      
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