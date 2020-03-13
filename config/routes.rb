Rails.application.routes.draw do
  devise_for :admins
  # deviseコントローラーのカスタマイズ(sign_up,sign_in時のpoint作成のため)
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions      => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'diaries#index'

  namespace :admins do
    resources :users, except: [:new, :create]
    resources :diaries, only: [:index, :show, :destroy]
  end

  resources :users, except: [:new, :create]
  get       'congfirm' => 'users#congfirm'

  resources :diaries
  resources :meal_records, except: [:index, :show]

end
