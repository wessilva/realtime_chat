class UsersController < ApplicationController
    def show 
    @users = current_user.added_users
    @groups = current_user.added_groups

    @user = User.find(params[:id])

    @message = current_user.messages.build
    @room_name = get_name(@user, current_user)

    @current_room = Room.where(name: @room_name).first || Room.create_nomed_room([@user, current_user], @room_name)
    @messages = @current_room.messages.order(created_at: :asc)
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    return "#{user[0].id}_#{user[1].id}"
  end
end
