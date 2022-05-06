class FollowRelationshipsController < ApplicationController
  def index
    @users = User.find(params[:user_id]).follows
  end
end
