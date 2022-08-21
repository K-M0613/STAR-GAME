class Admin::PostsController < ApplicationController
  def index
    @tag_list = Tag.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).post : Post.all
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    @post_tags = @post.tags
    @comments = @post.comments
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "削除しました。"
  end
end
