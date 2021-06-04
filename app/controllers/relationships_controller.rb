class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
    flash[:notice] = "#{ @user.name } さんをフォローしました。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
    flash[:notice] = "#{ @user.name } のフォローを解除しました。"
    redirect_back(fallback_location: root_path)
  end

end
