class Admin::PostsController < ApplicationController
  def index
    @user = User.find_by(params[:nickname])
    @tag_list = Tag.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).post : Post.all
    @post = Post.find_by(params[:id])
  end

  def show
    @user = User.find_by(params[:nickname])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "削除しました。"
  end
end
