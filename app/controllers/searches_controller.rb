class SearchesController < ApplicationController
  def search
    @records =
      if params[:target] == 'User'
        User.filter_by_name(params[:text], params[:matcher])
      else
        Book.filter_by_title(params[:text], params[:matcher])
      end 
  end
end
