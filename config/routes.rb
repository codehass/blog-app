Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [ :new, :destroy]
      resources :likes, only: [:new]
      end
    end

  # post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'
  post '/users/:user_id/posts/:id/likes', to: 'likes#create', as: 'create_post_like'
  # get '/posts/:post_id/comments/new', to: 'comments#new', as: 'new_post_comment'
  post '/posts/:post_id/comments', to: 'comments#create', as: 'create_post_comment'

end
