class BooksController < ApplicationController

  def index
    @books = Book.includes(:user, :category).order(id: :desc).page(params[:page]).per(15)
  end

  def show
    @book = Book.find(params[:id])
    @comments = @book.comments.includes(:user).order(id: :desc)
    @comment = Comment.new
    @user = @book.user
  end

  def new
    @book = Book.new
    @categories = Category.preload(:user).order(:name)
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
      @categories = Category.preload(:user).order(:name)
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
      @categories = Category.preload(:user).order(:name)
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
    @books = Book.where('title LIKE(?) OR author LIKE(?)', "%#{@keyword}%","%#{@keyword}%").includes(:user, :category).page(params[:page]).per(15)
  end

  private

  def book_params
    params.require(:book).permit(:user_id, :category_id, :title, :author, :body, :image)
  end
end
