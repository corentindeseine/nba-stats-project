Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/player-vs-player', to: 'pages#versus'
  resources :teams, only: %i[index show]
  resources :games, only: %i[index show]
  resources :players, only: %i[index show]
end
