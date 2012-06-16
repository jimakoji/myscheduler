Scheduler::Application.routes.draw do

  devise_for :users

  get 'schedules/month' => 'schedules#month', :as => 'month_schedules'
  get 'schedules/view_file' => 'schedules#view_file', :as => 'view_file_schedules'
  post 'schedules/search' => 'schedules#search', :as => 'search_schedules'
	get 'schedules/show' => 'schedules#show', :as => 'show_schedules'

	get 'account/list_group' => 'account#list_group', :as => 'account_list_group'
	get 'account/edit_group' => 'account#edit_group', :as => 'account_edit_group'
	get 'account/destroy_group' => 'account#destroy_group', :as => 'account_destroy_group'
	get 'account/new_group'=> 'account#new_group', :as => 'account_new_group'
	post 'account/create_group'=> 'account#create_group', :as => 'account_create_group'
	post 'account/update_group'=> 'account#update_group', :as => 'account_update_group'
  get 'account/list_member' => 'account#list_member', :as => 'account_list_member'
  get 'account/new_member' => 'account#new_member', :as => 'account_new_member'
  get 'account/edit_member' => 'account#edit_member', :as => 'account_edit_member'
	post 'account/create_member'=> 'account#create_member', :as => 'account_create_member'
	post 'account/update_member'=> 'account#update_member', :as => 'account_update_member'
	get 'account/destroy_member' => 'account#destroy_member', :as => 'account_destroy_member'
  
  resources :schedules


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "schedules#month"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'

end
