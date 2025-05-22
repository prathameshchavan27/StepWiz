Rails.application.routes.draw do
  resources :roadmaps
  devise_for :users
  resources :roadmap_steps
  root "roadmaps#index"
end
