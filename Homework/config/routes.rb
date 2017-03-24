Rails.application.routes.draw do
  devise_for :customers,controllers: {
        sessions: 'customers/sessions',
        registrations: 'customers/registrations'
      }
  devise_for :admins,controllers: {
        sessions: 'admins/sessions'
      }
  resources :admins,only:[:index]
  resources :customers,only:[:index]
  resources :bookings,except:[:edit,:update]
  resources :cleaners,:cities
  root 'customers#index'
  match '*path' => redirect('/404'), via: :get
end
