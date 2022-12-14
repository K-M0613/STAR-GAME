class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:edit, :destroy, :update]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿完了しました"
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

    if params[:tag_ids]
      @posts = []
      params[:tag_ids].each do |key, value|
        if value == "1"
           @tag_list = Tag.find_by(name: key).posts
           @posts = @posts.empty? ? @tag_list : @posts & @tag_list
           @posts = Kaminari.paginate_array(@posts).page(params[:page]).per(10)
        end
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @comment = Comment.new
    @comments = @post.comments
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.update(post_params)
      redirect_to post_path, notice: "投稿内容を更新しました"
    else
      flash[:notice] = "更新できませんでした"
      render :edit
    end
  end

  def search
    if params[:keyword].present?
      if params[:key_ascending] == "created_at asc"
        @posts = Post.where("title LIKE ?", "%#{params[:keyword]}%").order(created_at: :asc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "created_at desc"
        @posts = Post.where("title LIKE ?", "%#{params[:keyword]}%").order(created_at: :desc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "star asc"
        @posts = Post.where("title LIKE ?", "%#{params[:keyword]}%").order(star: :asc).page(params[:page]).per(10)
      elsif params[:key_ascending] == "star desc"
        @posts = Post.where("title LIKE ?", "%#{params[:keyword]}%").order(star: :desc).page(params[:page]).per(10)
      else
        @posts = Post.all.page(params[:page]).per(10)
      end
      @keyword = params[:keyword]
    else
      redirect_to request.referer, notice: "キーワードを入力してください"
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

    def post_params
      params.require(:post).permit(:purpose, :body, :title, :star, :user_id, :image, tag_ids: [],)
    end

    def baria_user
      unless Post.find(params[:id]).user.id.to_i == current_user.id
          redirect_to my_page_path(current_user)
      end
    end
end