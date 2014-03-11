Liberatio::Application.routes.draw do

  resources :issues

  resources :responses
  resources :tickets

  post "pusher/auth" => "pusher#auth"

  get "browse/home" => "browse#home"
  get "browse/roadmap" => "browse#roadmap", :as => "browse_roadmap"
  get "browse/pricing" => "browse#pricing", :as => "browse_pricing"
  get "browse/features" => "browse#features", :as => "browse_features"
  get "browse/buy" => "browse#buy", :as => "browse_buy"

  resources :inventories, :only => :create
  resources :users do
    get 'settings', :on => :member, :as => 'settings'
  end
  resources :instances
  resources :applications
  resources :organizations do
    get 'settings', :on => :member, :as => 'settings'
  end
  resources :nodes do
    resources :commands
    get 'registered', :on => :collection
    post 'register', :on => :collection
    get 'maintenance', :on => :collection, :as => "maintenance"
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
