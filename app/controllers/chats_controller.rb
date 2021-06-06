class ChatsController < ApplicationController

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    @chats = @room.chats.includes(:user).order(id: :desc)
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    rooms = current_user.user_rooms.pluck(:room_id)
    @chats = UserRoom.find_by(room_id: params[:chat][:room_id]).room.chats.includes(:user).order(id: :desc)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
