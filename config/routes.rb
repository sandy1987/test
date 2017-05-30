Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'passwords/create'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'registrations/create'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'sessions/create'
    end
  end

  namespace :api do
    namespace :v1 do
      get 'sessions/destroy'
    end
  end

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
    end
  end
end
