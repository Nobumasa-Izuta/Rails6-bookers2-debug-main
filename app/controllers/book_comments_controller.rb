class BookCommentsController < ApplicationController
  before_action :get_show_variables

  def create
    book_comment = BookComment.new(book_comment_params)

    if book_comment.save
      redirect_to params[:return_url].presence || book_path(book_comment.book_id)
    else
      render 'books/show'
    end
  end

  def destroy
    book_comment = BookComment.find(params[:id])

    if book_comment && book_comment.destroy
      redirect_to params[:return_url].presence || book_path(book_comment.book_id)
    else
      render 'books/show'
    end
  end

  private

  def get_show_variables
    @book = Book.includes(:favorites, book_comments: { user: { profile_image_attachment: :blob } }).find(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:book_id, :user_id, :comment)
  end
end
