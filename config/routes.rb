Rails.application.routes.draw do
  resources :parsers
  get 'categories/show'

  get 'products/show' => 'products#show'
  
  get 'products/showoncategory'

  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  root 'shop#index'
  controller :sessions do
    get  'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
  get "sessions/create"
  get "sessions/destroy"
  
  
  #root 'products#index' # - refer directly to index controller
  #et 'products/index' => 'products#index'
  
  devise_for :users # Apply the security for user model
 
  namespace :admin do #the same "Rails.application.routes.draw do" - when we want add "admin" to another root
    root 'products#index'
    #get 'users/index' => 'users#index'
    resources :products do     # /admin/products - can use CRUD
      collection do
        post 'destroyMulti'
      end
    end
    
    
    resources :categories   # /admin/categories - can use CRUD
    resources :users 
  end
  
  scope '(:locale)' do
    resources :orders
    resources :line_items
    resources :carts do 
     get 'delete' #root 'shop#index', as: 'shop', via: :all
   end
  end
end
