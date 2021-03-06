Rails.application.routes.draw do

  get 'main/search'

  get 'user/register'

  get 'main/index'

  get 'main/track'

  post 'main/explore_courses'

  get 'main/course_data/:id', to: 'main#course_data'

  post 'main/search_course'

  post 'main/update_course'

  post 'main/update_ap'

  post 'main/delete_course'

  post 'main/potential'

  post 'user/like'

  post 'user/dislike'

  get 'user/login'

  post 'user/post_login'

  get 'user/logout'

  get 'user/profile'

  post 'user/post_register'

  post 'user/post_track'

  post 'user/post_photo'

  post 'user/delete_account'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'user#login'

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
