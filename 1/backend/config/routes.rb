Rails.application.routes.draw do
  concern(:commentable) { resources :comments, only: %i[index create] }
  concern(:voteable) { resource :vote, only: %i[create] }

  resource :heartbeat, only: %i[show]

  post_concerns = %i[commentable voteable]
  resources :posts, only: %i[index], param: :token, concerns: post_concerns

  resources :subs, only: %i[], param: :name do
    resources :posts, only: %i[index create]
  end

  resources :users, only: %i[show create], param: :name do
    resource :salt, only: %i[show]
    resource :nonce, only: %i[create]
    resource :session, only: %i[create]
    resource :activation, only: %i[update]
    put 'password', on: :member
    patch 'password', on: :member
  end

  comment_concerns = %i[commentable voteable]
  resources :comments, only: %i[], param: :token, concerns: comment_concerns
end
