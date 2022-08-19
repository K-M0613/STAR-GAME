class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @book_marks = BookMark.where(user_id: @user.id)
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_delete: true)
    flash[:success] = "退会処理が完了しました"
    redirect_to admin_users_path
  end
end
