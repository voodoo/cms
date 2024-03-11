Rails.application.routes.draw do

  get '/robots' => "site#robots",  defaults: { format: 'text/plain' }
  get '/login'  => "user_sessions#new"
  delete '/logout' => "user_sessions#destroy"
  get '/css' => 'site#css',  :defaults => { :format => 'xml' }
  get '/contact' => 'site#contact'

  # Just an alias for now  
  get '/mblz' => 'mblz/now#index', as: :mblz
  
  # CLIENT INVOICES ########
  get '/invoice/:id' => "mblz/invoices#client", :as => 'client_invoice'
  get '/invoice/paid/:id' => "mblz/invoices#paid", :as => 'client_invoice_paid'

  get '/sitemap' => 'site#sitemap', :format => 'text/xml'
  
  ############## GALLERY ################
  get '/gallery/:name' => 'galleries#show'
  get '/gallery' => 'galleries#show', name: 'Gallery'
  get '/mblz/console' => 'mblz/now#console'
  
  #############  TWILIO
  #post '/twilios' => 'twilios/calls#index',  :defaults => { :format => 'xml' }

  get '/reviews' => 'mblz/customer_reviews#index',  :defaults => { :format => 'json' }
  get '/products' => 'mblz/products#index',  :defaults => { :format => 'json' }
  get '/categories' => 'mblz/product_categories#index',  :defaults => { :format => 'json' }

  resources :pages
  resources :galleries


  resources :user_sessions

  namespace :twilios, :defaults => { :format => 'xml' } do

    root :to => 'calls#new'

    resources :calls do
      collection do
        post :recording
        post :answered
        get :recording
        post :recording_complete
        post :transcription_complete
        post :activities
        post :outgoing
      end
    end
    resources :outgoing_calls do
      collection do
        post :complete
      end
    end
    resources :messages

    namespace :console do
      root :to => 'boards#index'
      resources :boards
      resources :messages
      resources :pins
      resources :auths
      resources :greetings do
        collection do
          post :recorded
        end
      end
      resources :contacts do
        member do
          post :action
          post :recording_complete
          post :transcription_complete
        end
      end
    end

  end

  resources :demos do

  end

  resources :forms do
    collection do
      get :thank_you
    end
  end

  resources :faqs
  

  namespace :mblz do
    root :to => 'now#index'


    resources :products do
      member do
        get :sales
        post :upload_image
      end
    end
    resources :product_inventories do
      collection do
        get :current
        get :sales
        get :problems
        get :details
      end
    end
    resources :product_invoices do
      collection do
         get :item
      end      
      member do
        get :print
      end
    end

    resources :product_categories

    resources :blips, :now, :users, :phones, :comments
    resources :submissions, :outgoing_calls, :invoice_item_defaults
    resources :tags
    resources :ways

    resources :activities
    resources :reviews

    resources :incoming_calls do
      member do
        put :release
      end
    end

    resources :reports do
      collection do
        get :sales
        get :sales_by_year
      end
    end

    resources :contacts do
      collection do
        get :create_from_form
        get :lookup
        get :uniq
        get :export_all
      end
      member do
        get :export
        get :release_priority
        get :outgoing_phone_call
        get :touch
        put :update_priority
        get :call
        get :map
        #put :update_contactables
      end
      resources :comments do
        member do
          get :set_link
        end
      end
      resources :tags
    end
    resources :invoices do
      member do
        post :update_status
        post :update_item_publishable
        get :send_to_contact
        get :client
        post :dupe
      end
      collection do
         get :item
         get :reports
         get :export
         get :export_all
         get :map
      end
      resources :comments do
        member do
          get :set_link
        end
      end      
      resources :estimate_confirmations
      resources :reviews
      resources :customer_reviews
      
      resources :invoice_payments
      resources :attachments do
        member do
          put :move
        end
      end
    end
  end 
  
  namespace :cms do
    root :to => 'dashboard#index'
    
    #resource :iphone, :as => 'iphone'
    resources :styles#, :collection => {:sort => :post}, :member => {:version => :put}
    resources :pages do
       collection do
         post :sort
         post :copy
       end
    end
    #=> :post, :copy => :post, :paste => :get}, :member => {:version => :put}
    resources :layouts do
      collection do
        post :sort
      end
      member do
        put :version
      end
    end
    resources :uploads do
      member do
        get :move
      end
    end
    resources :folders do
      member do
        get :move
      end
    end
  end

  namespace :admin do
    root :to => 'home#index'
    resources :tables
    resources :demos
    resources :tags
    resources :activities
    resources :contacts
    resources :incoming_calls
    resources :wheres

    
    resources :activities do
      collection do
        get :user
      end
    end
    resources :paths do
      member do
        get :by_session
        get :site
      end
      collection do
        put :clear
        get :sites
      end      
    end    
    resources :sites do
      member do
        get :fake_data
        get :utility
        #post :update_site_access
      end
      resources :domains
      resources :tags

    end
    
    resources :forms do
      resources :fields  
    end
    
    resources :domains

    resources :users do
      member do
        post :update_site_access
      end
    end
    resources :twilio_configs do
      resources :phones
      collection do
        get :release_number
        get :active_numbers
      end
      member do
        get :numbers
        get :set_number
      end
    end

    resources :demos

  end

  #get "*url" => "site#show_page"
  #root :to   => "site#show_page"
  root :to => "user_sessions#new"  


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
