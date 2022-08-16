class Admin::PostsController < ApplicationController
  def index
    @tag_list = Tag.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).post : Post.all
    @post = Post.find_by(params[:id])
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
