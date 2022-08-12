class PostImage < ApplicationRecord
  # ActiveStoreage を使って画像を持たせる
  has_one_attached :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :shop_name, presence: true
  validates :image, presence: true

  # 引数で渡されたユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べ、 存在していればtrue、存在していなければfalseを返す
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  # メソッド作成
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
