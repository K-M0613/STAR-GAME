class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, notice: '投稿完了しました:)'
    else
      render :new
    end
  end

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

  def index_user
    @posts = Blog.where(user_id: params[:id])
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
    @comments = @post.comments
  end

  def search
    if params[:keyword].present?
      @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").page(params[:page]).per(10)
      @keyword = params[:keyword]
    else
      @posts = Post.all.page(params[:page]).per(10)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "削除しました。"
  end

  private

  def post_params
    params.require(:post).permit(:purpose, :body, :title, :star, :user_id, tag_ids: [],)
  end
end
