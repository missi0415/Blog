class BooksController < ApplicationController

  def index
    @books = Book.all
  end

  def show

  end

  def new
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])

  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "投稿しました。"
      redirect_to books_path
    else
      render :new
    end
  end

  def update

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "投稿を削除しました。"

  end

  private

  def book_params
    params.require(:book).permit(:user_id, :category_id, :title, :author, :body, :image)
  end
end
