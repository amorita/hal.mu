Hal::Application.routes.draw do


  devise_for :user, controllers: {
   omniauth_callbacks: "omniauth_callbacks",
   sessions: "sessions"
 }
  
#  devise_for :users

  
  resources :sharedfiles

  resources :poster_candidates

  resources :nontans, :path => 'aaa' do
    collection do
      get 'intro'
      get 'index2'
    end
  end

  resources :enq_answers

  resources :practice_plns do
    member do
      get 'mail_notif'
      patch 'update_sendmail'
    end
    collection do
      get 'next'
      get 'all_plns'
    end
  end
  
  resources :practice_places

  resources :tests
  get 'tweets' => 'tweets#index'
  
  resources :podcast do
    collection do
      get 'rehearsal'
      get 'rehearsal_prev'
      get 'concert'
    end
  end
  
  resources :ical
  
  resources :concerts, :only => [:index, :show] do
    collection do
      get 'next'
      get 'future'
    end
  end
  
  resources :topics, :only => [:index]

  resources :application_acceptance do
    collection do
      patch 'part_accept'
      get 'somu_index'
      patch 'somu_accept'
    end
    member do
      get 'somu_edit'
    end
  end

  resources :concerts, :only => [:index, :show] do
    collection do
      get 'next'
      get 'future'
    end
  end
  
  resources :topics, :only => [:index]

  resources :personal_data do
    collection do
      get 'join'
      patch 'join_process'
    end
  end

  get 'main' => 'main#index'

  post 'auth/validate' => 'auth#validate'
  get 'auth/logout' => 'auth#logout'

  resources :users
  
  root "user#login"

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
