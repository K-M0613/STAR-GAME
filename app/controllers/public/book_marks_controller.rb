class Public::BookMarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @book_marks = BookMark.all
  end

  def create
    @post = Post.find_by(id: params[:post_id])
    @book_marks = @post.book_marks.new(user_id: current_user.id)
    @book_marks.save
  end

  def destroy
    @post = Post.find_by(id: params[:post_id])
    @book_marks = @post.book_marks.find_by(user_id: current_user.id)
    @book_marks.present?
    @book_marks.destroy
  end
end
