class BookCommentsController < ApplicationController
  def create
    book_comment = BookComment.new(book_comment_params)
    book_comment.save

    @book = Book.includes(:favorites, book_comments: { user: { profile_image_attachment: :blob } }).find(params[:book_id])
  end
  

  def destroy
    book_comment = BookComment.find(params[:id])
    book_comment.destroy

    @book = Book.includes(:favorites, book_comments: { user: { profile_image_attachment: :blob } }).find(params[:book_id])
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :user_id, :comment)
  end
end
