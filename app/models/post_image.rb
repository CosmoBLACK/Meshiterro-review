class PostImage < ApplicationRecord
  # ActiveStoreage を使って画像を持たせる
  has_one_attached :image
end
