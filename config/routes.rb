Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'diaries#index'

  namespace :admins do
    resources :users
    resources :diaries
  end

  resources :users,        except: [:new, :create]
  get       'congfirm' => 'users#congfirm'

  resources :diaries
  resources :meal_records, except: [:index, :show]


end
