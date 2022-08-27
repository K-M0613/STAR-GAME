class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @tag_list = Tag.all
    if params[:latest]
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.latest
      @posts = @posts.page(params[:page]).per(10)
    elsif params[:old]
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.old
      @posts = @posts.page(params[:page]).per(10)
    elsif params[:star_count]
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.star_count
      @posts = @posts.page(params[:page]).per(10)
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
      @posts = @posts.page(params[:page]).per(10)
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comments = @post.comments
  end
  
  def search
    if params[:keyword].present?
      if params[:key_ascending] == "created_at asc"
        @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").order(created_at: :asc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "created_at desc"
        @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").order(created_at: :desc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "star asc"
        @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").order(star: :asc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "star desc"
        @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").order(star: :desc).page(params[:page]).per(10)
      else
       @posts = Post.all.page(params[:page]).per(10)
      end
      @keyword = params[:keyword]
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: "削除しました。"
  end
end
