class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    # tag_list=params[:post][:name].split(',')
    # binding.pry
    if @post.save
      # binding.pry
      # @post.save_tag(tag_list)
      redirect_to posts_path, notice: '投稿完了しました:)'
    else
      render :new
    end
  end

  def index
    @tag_list = Tag.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @posts = @posts.page(params[:page]).per(10)
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
    @comments = @post.comments
  end

  def search
    if params[:keyword].present?
      @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%").page(params[:page]).per(5)
      @keyword = params[:keyword]
    else
      @posts = Post.all.page(params[:page]).per(5)
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:purpose, :body, :title, :star, :user_id, tag_ids: [],)
  end
end
