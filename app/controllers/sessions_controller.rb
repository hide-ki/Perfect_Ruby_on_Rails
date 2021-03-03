class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    # request.evn["omniauth.auth"]というhashに似たOmniAuth::AuthHashクラスのオブジェクトを利用する
    # そのオブジェクトの中には、githubから渡されたユーザー情報やoauthのアクセストークンを含む
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "ログインしました"
  end

  def destroy
    # reset_sessionメソッド、sessionに入っていた値を削除する
    reset_session
    redirect_to root_path, notice: "ログアウトしました"
  end
end
