Rails.application.routes.draw do
  # concern(:postable) { resources :posts }

  # user_concerns = [:postable]
  # resources :users, param: :name, concerns: user_concerns

  # sub_concerns = [:postable]
  # resources :subs, param: :name, concerns: sub_concerns

  resources :users, param: :name

  resources :subs, param: :name

  resources :posts, param: :token

  resource :heartbeat, only: :show
end
