class ApplicationController < ActionController::Base
  # before_actionメソッドは、このコントローラが動作する前に実行される
  # authenticate_userメソッドは、Devise側が用意しているメソッドで、:authenticate_user!とすることによって、「ログイン認証されていなければ、ログイン画面へリダイレクトする」機能を実装できる
  # exceptは指定したアクションをbefore_actionの対象から外す機能があり、トップページのみログイン状態に関わらず、アクセス可能とするためにtopアクションを指定している
  before_action :authenticate_user!, except: [:top]
  # devise利用の機能（ユーザ登録、ログイン認証など）が使われる前にconfigure_permitted_parametersメソッドが実行される
  before_action :configure_permitted_parameters, if: :devise_controller?
  # deviseが用意しているメソッドで、サインイン後にどこに遷移するかを設定するメソッド
  def after_sign_in_path_for(resource)
    post_images_path
  end
  # deviseが用意しているメソッドで、サインアウト後にどこに遷移するかを設定するメソッド
  def after_sign_out_path_for(resource)
    about_path
  end
  # privateは記述をしたコントローラ内でしか参照できないが、protectedは呼び出された他のコントローラからも参照できる
  protected
  # ユーザー登録(sign_up)の際に、ユーザー名(name)のデータ操作を許可している
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
