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
    @user = User.find_by(params[:nickname])
    @tag_list = Tag.all
    @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    @post = Post.find_by(params[:id])
  end

  def show
    @user = User.find_by(params[:nickname])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def search
    if params[:keyword].present?
      @posts = Post.where('title LIKE ?', "%#{params[:keyword]}%")
      @keyword = params[:keyword]
    else
      @posts = Post.all
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:purpose, :comment, :title, :star, tag_ids: [],)
  end
end
