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
      get 'dashboard/contact_info'
      get 'dashboard/home'
      get 'dashboard/terms_of_aggrement'
      get 'passwords/create'
      get 'registrations/create'
      get 'sessions/create'
      get 'sessions/destroy'
      get 'profiles/edit'
      get 'profiles/show'
      get 'profiles/update'
    end
  end

end
