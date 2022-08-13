Rails.application.routes.draw do
  namespace :public do
    get 'comments/create'
    get 'comments/destroy'
  end
  get 'comments/create'
  get 'comments/destroy'
   devise_for :admins, skip: [:registrations, :passwords], controllers: {
     sessions: "admin/sessions"
   }

   devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
   end



   devise_for :users, controllers: {
     registrations: "public/registrations",
     sessions: 'public/sessions'
   }

   scope module: :public do
       resources :posts, only: [:new, :index, :show, :create, :destroy] do
         resources :comments, only: [:create, :destroy]
         resource :book_marks, only: [:index, :create, :destroy]
         get :search, on: :collection
       end
        get '/users/:id/edit' => 'users#edit', as: 'user_edit'
        patch 'users/:id' => 'users#update', as: 'update_user'
        get 'users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
        patch 'users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
        get 'users/:id/show' => 'users#show', as: 'my_page'

        root to: "homes#top"
        get "about" => "homes#about", as: "about"

        get 'games/search' => 'games#search'


   end










  namespace :admin do
    root to: "admin/homes#top"
    get 'users/index' => 'users#index', as: 'users'
    get 'users/show' => 'users#show', as: 'user'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :posts, only: [:index, :show, :destroy]
  end





  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
