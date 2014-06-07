Liberatio::Application.routes.draw do

  resources :subscriptions do
    get 'welcome', :on => :collection, :as => "welcome"
  end

  get "au/latest" => "automatic_updates#latest"

  resources :issues

  resources :responses
  resources :tickets

  # Needed by Pusher C# Client for authentication
  post "pusher/auth" => "pusher#auth"
  post "pusher/webhook" => "pusher#webhook"

  get "browse/home" => "browse#home"
  get "browse/about" => "browse#about", :as => "browse_about"
  get "browse/contacts" => "browse#contacts", :as => "browse_contacts"
  get "browse/privacy" => "browse#privacy", :as => "browse_privacy"
  get "browse/pricing" => "browse#pricing", :as => "browse_pricing"
  get "browse/features" => "browse#features", :as => "browse_features"
  get "browse/buy" => "browse#buy", :as => "browse_buy"
  get "browse/download" => "browse#download", :as => "browse_download"
  get "browse/getting_started" => "browse#getting_started", :as => "browse_getting_started"
  get "browse/faq" => "browse#faq", :as => "browse_faq"
  get "browse/documentation" => "browse#documentation", :as => "browse_documentation"
  get "browse/configuring_agent" => "browse#configuring_agent", :as => "browse_configuring_agent"

  resources :inventories, :only => :create
  resources :users do
    get 'settings', :on => :member, :as => 'settings'
  end
  resources :instances
  resources :applications
  resources :organizations do
    get 'regenerate_registration_code', on: :collection
  end
  resources :nodes do
    resources :commands
    get 'registered', :on => :collection
    post 'register', :on => :collection
    get 'maintenance', :on => :collection, :as => "maintenance"
    get 'dashboard', :on => :collection, :as => "dashboard"
  end

  resources :sessions
  get "sessions/new" => "sessions#new", :as => "login"
  delete "sessions/destroy" => "sessions#destroy", :as => "logout"
  get "sessions/forgot_password" => "sessions#forgot_password", :as => "forgot_password"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  root 'browse#home'
end
