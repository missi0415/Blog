class CommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.book_id = @book.id
    if @comment.save
      flash[:notice] = "コメントしました。"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "内容を入力してください。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    Comment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_back(fallback_location: root_path)
  end


  private

  def comment_params
    params.require(:comment).permit(:user_id, :book_id, :comment)
  end
end
