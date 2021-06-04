class LikesController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @like = current_user.likes.new(book_id: @book.id)
    @like.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    like = current_user.likes.find_by(book_id: @book.id)
    like.destroy
  end

end
