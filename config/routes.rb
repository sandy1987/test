Rails.application.routes.draw do

  devise_for :users

  root to: 'application#home'

  resources :profiles
  resources :work_schedules
  
  get '/next_schedule' => "work_schedules#next_schedule", as: :next_schedule
  match '/my_schedule' => "work_schedules#my_schedule", as: :my_schedule, via: [:get, :post]

end
