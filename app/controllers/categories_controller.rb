class CategoriesController < ApplicationController

  def index
    @categories = Category.order(:name).page(params[:page]).per(20)
  end

  def show
    @category = Category.find(params[:id])
    @books = Book.where(category_id: @category.id).page(params[:page]).per(15)
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to new_book_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
