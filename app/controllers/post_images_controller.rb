class PostImagesController < ApplicationController
  def new
    @post_image = PostImage.new
  end

  def create
    # 投稿するデータをPostImageモデルに紐づくデータとして保存する準備をしていて、フォームに入力されたデータが、@post_imageに格納される
    @post_image = PostImage.new(post_image_params)
    # user_id は、PostImageモデル作成時に作ったカラムで、画像投稿を行う際に「どのユーザーが投稿したのか」を「ユーザーのIDで判断する」ためのカラム
    # @post_image(投稿データ)のuser_idを、current_user.id(今ログインしているユーザーのID)に指定することで投稿データに、今ログイン中のユーザーのIDを持たせることができる
    @post_image.user_id = current_user.id
    # PostImageモデルへ保存した後、投稿一覧画面へリダイレクト
    if @post_image.save
      redirect_to post_images_path
    else
      render :new
    end
  end

  def index
    # 1ページ分の決められた数のデータだけを、新しい順に取得する
    @post_images = PostImage.page(params[:page])
  end

  def show
    @post_image = PostImage.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    #  削除するPostImageレコードを取得
    @post_image = PostImage.find(params[:id])
    @post_image.destroy
    redirect_to post_images_path
  end

  private
  # フォームで入力されたデータが、投稿データとして許可されているパラメータかどうかをチェックする
  def post_image_params
    params.require(:post_image).permit(:shop_name, :image, :caption)
  end
end
