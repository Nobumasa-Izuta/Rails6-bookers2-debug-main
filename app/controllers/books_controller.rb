class BooksController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def show
    @book = Book.includes(:favorites, book_comments: { user: { profile_image_attachment: :blob } })
                .find(params[:id])
  end

  def index
    @book = Book.new
    @books = Book.order((index_params[:sort_column].presence || 'created_at').to_sym => :desc)
                 .filter_by_category(index_params[:category])
                 .includes(:favorites, :book_comments, user: { profile_image_attachment: :blob })
  end

  def create
    @book = Book.new(new_book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(edit_book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def new_book_params
    params.require(:book).permit(:title, :body, :category, :rating)
  end

  def edit_book_params
    params.require(:book).permit(:title, :body, :category)
  end

  def index_params
    params.permit(:category, :sort_column)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
