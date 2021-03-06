Mpate::Application.routes.draw do

  get "settings/index"
  # We're overriding the competitor :id here, so this
  # route must come before the competitors resource.
  # Rountes are prioritized top-down.
  
  get 'competitors/badges' => 'competitors#badges', as: 'badges'
  get 'teams/setup' => 'teams#setup', as: 'setup_teams'
  post 'teams/assign_room' => 'teams#assign_room', as: 'assign_room'
  post 'settings/save_all' => 'settings#save_all', as: 'save_all_settings'

  delete 'competitors/reset' => 'competitors#reset', as: 'reset_competitors'
  delete 'leaders/reset' => 'leaders#reset', as: 'reset_leaders'
  delete 'schools/reset' => 'schools#reset', as: 'reset_schools'
  delete 'tasks/reset' => 'tasks#reset', as: 'reset_tasks'
  delete 'teams/reset' => 'teams#reset', as: 'reset_teams'
  delete 'volunteers/reset' => 'volunteers#reset', as: 'reset_volunteers'

  resources :competitors
  resources :teams
  resources :managers
  resources :tasks
  resources :volunteers
  resources :leaders
  resources :schools
  resources :sessions
  resources :settings

  get 'login' => 'sessions#new'
  get 'logout' => 'sessions#destroy'

  get 'results' => 'teams#results'

  root "main#index"

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
end
