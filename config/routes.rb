Rails.application.routes.draw do

  devise_for :users

  root to: 'dashboard#home'

  resources :profiles
  resources :work_schedules
  
  get '/next_schedule' => "work_schedules#next_schedule", as: :next_schedule
  get '/my_schedule' => "work_schedules#my_schedule", as: :my_schedule

  get '/contact' => "dashboard#contact_info", as: :contact_info
  get '/terms_of_agreement' => "dashboard#terms_of_agreement", as: :terms_of_agreement

  namespace :api do
    namespace :v1 do
      devise_for :users
      # Dashboard
      get 'dashboard/contact_info'
      get 'dashboard/home'
      get 'dashboard/terms_of_aggrement'
      # Password
      post 'passwords/create'
      # Registration
      post 'registrations/create'
      # Session
      post 'sessions/create'
      delete 'sessions/destroy'
      # Profile
      get 'profiles/edit'
      get 'profiles/show'
      patch 'profiles/update'
      # Work Schedule
      post 'work_schedules/create'
      delete 'work_schedules/destroy'
      get 'work_schedules/edit'
      get 'work_schedules/index'
      get 'work_schedules/my_schedule'
      get 'work_schedules/new'
      get 'work_schedules/next_schedule'
      get 'work_schedules/show'
      patch 'work_schedules/update'
    end
  end

end
