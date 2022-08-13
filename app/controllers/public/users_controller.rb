class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @book_marks = BookMark.where(user_id: @user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "更新しました"
      redirect_to my_page_path
    else
      render :edit
    end
  end

  def unsubscribe
  end

  def withdraw
    @user = User.find(params[:id])
    @user.update(is_delete: true)
    reset_session
    flash[:success] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :gender, :birth_day, :profile_image_url, :is_delete, tag_ids: [])
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.nickname == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end
end
