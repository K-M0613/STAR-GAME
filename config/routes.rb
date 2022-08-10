Rails.application.routes.draw do
   devise_for :admins, skip: [:registrations, :passwords], controllers: {
     sessions: "admin/sessions"
   }

   devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
   end

   get 'users/edit' => 'public/users#edit', as: 'edit_user'
   get 'users' => 'public/users#update', as: 'update_user'

   devise_for :users, controllers: {
     registrations: "public/registrations",
     sessions: 'public/sessions'
   }

   scope module: :public do
       resources :posts, only: [:new, :index, :show, :search, :create, :destroy]
   end

   root to: "public/homes#top"
   get "about" => "public/homes#about", as: "about"



   get 'users/unsubscribe' => 'public/users#unsubscribe', as: 'unsubscribe'
   patch 'users/withdraw' => 'public/users#withdraw', as: 'withdraw'
   get 'users/my_page' => 'public/users#show', as: 'my_page'


   get 'games/search' => 'public/games#search'

   resources :book_marks, only: [:index, :create, :destroy]

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
