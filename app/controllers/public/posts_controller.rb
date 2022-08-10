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
      redirect_to post_path(@post), notice: '投稿完了しました:)'
    else
      render :new
    end
  end

  def index
    @tag_list = Tag.all
    @posts = Post.all
    @post = current_user.post.new
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
  end

  def search
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:purpose, :comment, :title, :star, tag_ids: [],)
  end
end
