class FavoritesController < ApplicationController
  before_action :get_index_variables

  def create
    favorite = Favorite.new(book_id: params[:book_id], user_id: current_user.id)

    if favorite.save
      redirect_to params[:return_url].presence || books_path
    else
      render 'books/index'
    end
  end

  def destroy
    favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)

    if favorite && favorite.destroy
      redirect_to params[:return_url].presence || books_path
    else
      render 'books/index'
    end
  end

  private

  def get_index_variables
    @book = Book.new
    @books = Book.all.includes(:favorites, user: { profile_image_attachment: :blob })
  end
end
