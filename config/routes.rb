Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  # resourcesメソッドは、ルーティングを一括して自動生成してくれる機能を有する
  # onlyオプションを使用することで、生成するルーティングを限定する
  get 'homes/about' => 'homes#about', as: 'about'
  # コメントは、投稿画像に対してなされるため、post_commentsは、post_imagesに結びつき、以下のような親子関係になる
  # params[:post_image_id]でPostImageのidが取得できるようになる
  resources :post_images, only: [:new, :index, :show, :create, :destroy] do
    resource :favorites, only: [:create, :destroy] # resourcesでなくresourceとなると、/:idがURLに含まれなくなる
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:show, :edit, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
