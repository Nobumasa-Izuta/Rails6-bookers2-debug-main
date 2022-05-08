class FavoritesController < ApplicationController
  def create
    @favorite = Favorite.new(book_id: params[:book_id], user_id: current_user.id)
    @favorite.save
  end

  def destroy
    @favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    @favorite.destroy
  end
end
