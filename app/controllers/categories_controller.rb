class CategoriesController < ApplicationController

  def index
    @categories = Category.all.order(id: :desc)
  end

  def show
    @category = Category.find(params[:id])
    @books = Book.where(category_id: @category.id)
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to new_book_path
  end

  def update

  end

  def destroy

  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
