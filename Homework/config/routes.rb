Rails.application.routes.draw do
  devise_for :admins
  resources :admins,:cleaners,:cities
  root 'admins#index'

end
