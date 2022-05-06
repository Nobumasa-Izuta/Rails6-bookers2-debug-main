class FollowerRelationshipsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).followers
  end
end
