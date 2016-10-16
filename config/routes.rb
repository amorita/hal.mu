Hal::Application.routes.draw do


  resources :slips
  resources :slip_dtls do
    collection do
      post 'index'
    end
  end

devise_for :user, :controllers => { :omniauth_callbacks => "user/omniauth_callbacks" }

devise_scope :user do
  get 'sign_in', :to => 'devise/sessions#new', :as => :new_session
  get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_session
end
#  devise_for :users

  
  resources :sharedfiles do
    collection do
      get 'all_index'
    end
  end

  resources :poster_candidates

  resources :nontans, :path => 'aaa' do
    collection do
      get 'intro'
      get 'index2'
      post 'history'
      get 'history'
    end
  end

  resources :enq_answers
  resources :campaigns

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
      get 'concert_recordings'
      get 'concert', :action => 'concert_recordings'
    end
  end
  
  resources :ical
  
  resources :concerts, :only => [:index, :show] do
    collection do
      get 'next'
      get 'future'
    end
  end
  
  get 'fees' => 'fees#index'
  get 'fees/payee' => 'fees#payee'
  post 'fees/check' => 'fees#check'
  get 'fees/check' => 'fees#check'

  resources :topics, :only => [:index]
  resources :events

  resources :application_acceptance do
    collection do
      patch 'part_accept'
      get 'somu_index'
      patch 'somu_accept'
      get 'accountant_index'
      patch 'accountant_accept'
      get 'president_index'
      patch 'president_accept'
      post 'absence_new'
      get 'absence_init'
      get 'retire_new'
      get 'return_new'
    end
    member do
      get 'somu_edit'
      get 'president_edit'
      get 'accountant_edit'
    end
  end

  resources :camp_attendances do
    collection do
      get 'edit_self'
      get 'payment_status'
      post 'update_payment_status'
    end
  end

  resources :personal_data do
    collection do
      get 'join'
      patch 'join_process'
      get 'index'
      post 'index'
      get 'members'
    end
  end

  get 'main' => 'main#index'

  post 'auth/validate' => 'auth#validate'
  get 'auth/logout' => 'auth#logout'

  get 'parts/status' => 'parts#status'


  resource :camp, :controller => :camp do
    collection do 
      get 'edit'
    end
  end

  resources :users
  
  root "user#login"

  resources :account_transactions
  post 'account_transactions/import'

  get 'ticket_reservations/edit' => 'ticket_reservations#edit'
  post 'ticket_reservations/update' => 'ticket_reservations#update'
  get 'ticket_reservations/list' => 'ticket_reservations#list'
  get 'ticket_reservations/receive' => 'ticket_reservations#receive'
  get 'admins' => 'admins#index'
  get 'guide' => 'guide#index'
  get 'terms' => 'guide#terms'
  get 'clubs' => 'clubs#index'
  get 'instagram' => 'instagram#index'

  get 'line/auth' => 'line#auth'

  resources :mls

  resources :zip_codes, only: [:show]

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
