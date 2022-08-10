class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
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
    current_user.update(is_delete: true)
    sign_out current_user
    flash[:success] = "退会しました"
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :sex, :birth_day, :profile_image_url, :is_delete)
  end
  
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end
