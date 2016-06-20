Rails.application.routes.draw do
  get 'products/for_sale'
  get 'products/order'
  get 'products/search',to: 'products#search', as: 'search_product'
  get 'products/tag',to: 'products#tag', as: 'tag_product'
  get 'collections/show'
  post 'collections/new'
  post 'collections/remove'
  post 'orders/remove'
  post 'products/remove'
  post 'products/selled'
  post 'products/cancel'
  post 'products/:id/orders', to: 'orders#create', as: 'new_order'
  post 'products/create'

  resources :products
  resources :orders

  mount RailsAdmin::Engine => '/admin/renmiaoshinvde', as: 'rails_admin'

  devise_for :users , controllers: {registrations: "registrations"}
  resources :users

  get 'home/index'
  get 'home/minor'
  get 'other/check', to: 'other#check' , as: 'check'

  get 'user_edit/show'
  patch 'user_edit/edit'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  post 'orders/notify_email', to: 'orders#notify_email'
  post 'orders/notify_text', to: 'orders#notify_text'

  # You can have the root of your site routed with "root"

  root 'home#index'

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
end
