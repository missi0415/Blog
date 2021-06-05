class BooksController < ApplicationController

  def index
    @books = Book.all.order(id: :desc)
  end

  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.order(id: :desc)
    @comment = Comment.new
    @user = @book.user
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def edit
    @book = Book.find(params[:id])
    @categories = Category.all
  end

  def create
    if params[:book][:category_id] == ""
      params[:book][:category_id] = Category.find_or_create_by(name: params[:book][:name]).id
    end
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "投稿しました。"
      redirect_to books_path
    else
      @categories = Category.all
      render :new
    end
  end

  def update
    if params[:book][:category_id] == ""
      params[:book][:category_id] = Category.find_or_create_by(name: params[:book][:name]).id
    end
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to books_path, notice: "編集を登録しました。"
    else
      @categories = Category.all
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "投稿を削除しました。"
  end

  def search
    @keyword = params[:keyword]
    @books = Book.where('title LIKE(?)', "%#{@keyword}%")
  end

  private

  def book_params
    params.require(:book).permit(:user_id, :category_id, :title, :author, :body, :image)
  end
end
