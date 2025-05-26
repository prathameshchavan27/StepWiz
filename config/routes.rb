Rails.application.routes.draw do
  get "users/show"
  resources :roadmaps
  devise_for :users
  get 'profile', to: 'users#profile'
  resources :roadmap_steps do
    patch :move_up,   on: :member
    patch :move_down, on: :member
    resources :step_completions, only: [ :create, :destroy ]
  end
  resources :focus_sessions
  root "roadmaps#index"
end
