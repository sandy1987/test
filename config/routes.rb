Rails.application.routes.draw do
  resources :work_schedules
  resources :profiles
  devise_for :users

  root to: 'application#home'

  get '/next_schedule' => "work_schedules#next_schedule", as: :next_schedule

end
