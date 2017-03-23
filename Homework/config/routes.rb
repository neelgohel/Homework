Rails.application.routes.draw do
  devise_for :customers,controllers: {
        sessions: 'customers/sessions',
        registrations: 'customers/registrations'
      }
  devise_for :admins,controllers: {
        sessions: 'admins/sessions'
      }
  resources :admins,:cleaners,:cities,:customers,:bookings
  root 'customers#index'
  match '*path' => redirect('/404'), via: :get
end
