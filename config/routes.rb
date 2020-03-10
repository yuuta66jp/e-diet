Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'diaries#index'

  resources :users,        except: [:new, :create]

  resources :diaries

  resources :meal_records, except: [:index, :show]


end
