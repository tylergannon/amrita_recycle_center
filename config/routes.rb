AmritaRecycleCenter::Application.routes.draw do
  devise_for :users
  resources :time_entries

  resources :tasks

  resources :transfer_line_items

  resources :containers

  resources :transfers

  resources :locations

  resources :categories
  
  resources :worksheets
  
  root to: 'transfers#index'
  
  get 'time_entries/by_date/:date' => 'time_entries#index', as: :time_entries_by_date
end
