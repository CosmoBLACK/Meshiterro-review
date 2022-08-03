Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # resourcesメソッドは、ルーティングを一括して自動生成してくれる機能を有する
  # onlyオプションを使用することで、生成するルーティングを限定する
  resources :post_images, only: [:new, :index, :show]
  get 'homes/about' => 'homes#about', as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
