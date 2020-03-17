Rails.application.routes.draw do
  devise_for :admins
  # deviseコントローラーのカスタマイズ(sign_up,sign_in時のpoint作成のため)
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions      => 'users/sessions'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # ルート設定
  root 'home#top'
  # aboutページ設定
  get 'home/about', to: 'home#about'
  # namespaceを使い指定のパス(admin)にする
  namespace :admins do
    resources :users, except: [:new, :create]
    resources :diaries, only: [:index, :show, :destroy]
    resources :rewards, only: [:index, :destroy]
    resources :genres,  only: [:index, :create, :edit, :update]
    resources :topics
  end
  # ルーティングをネストする
  resources :users, except: [:new, :create] do
    resource :relationships, only: [:create, :destroy]
    # 自user以外のidが必要なためresourcesによって作成
    resources :relationships, only: [:index]
  end
  get       'congfirm' => 'users#congfirm'

  # ルーティングをネストする
  resources :diaries do
    resources :diary_comments, except: [:new, :index]
  end

  resources :meal_records, except: [:index, :show]
  resources :rewards,        only: :index
  resources :topics,         only: [:index, :show]

end
