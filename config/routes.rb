Rails.application.routes.draw do
  resources :roadmaps
  devise_for :users
  resources :roadmap_steps do
    patch :move_up,   on: :member
    patch :move_down, on: :member
    resources :step_completions, only: [ :create, :destroy ]
  end
  root "roadmaps#index"
end
