Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # resourcesメソッドは、ルーティングを一括して自動生成してくれる機能を有する
  # onlyオプションを使用することで、生成するルーティングを限定する
  get 'homes/about' => 'homes#about', as: 'about'
  resources :post_images, only: [:new, :index, :show, :create, :destroy]
  resources :users, only: [:show, :edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
