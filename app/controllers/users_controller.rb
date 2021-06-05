class UsersController < ApplicationController

  def index
    @users = User.order(id: :desc).page(params[:page]).per(9)
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books.order(id: :desc)
    @follower = Relationship.where(follow_id: @user.id)
  end

  def following
    @user = User.find(params[:user_id])
    following_id = @user.relationships.pluck(:follow_id)
    @following_users = []
    following_id.each do |f|
      @following_users.append(User.find(f))
    end
    @followers = Relationship.where(follow_id: params[:user_id])
  end

  def followers
    @user = User.find(params[:user_id])
    followers_id = Relationship.where(follow_id: params[:user_id]).pluck(:user_id)
    @followers = []
    followers_id.each do |f|
      @followers.append(User.find(f))
    end
  end

end
