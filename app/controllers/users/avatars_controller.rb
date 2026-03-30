class Users::AvatarsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user

    include ActionView::RecordIdentifier # include dom_id method identifier
 
    def destroy

        # Broadcasting Logic
        # if current_user
        #    UserUpdateProfileJob.set(wait: 1.seconds).perform_later(
        #      current_user.id
        #   )
        #end

        # Remove the avatar attachment, its blob, and the stored file asynchronously
        @user.avatar.purge_later
       
        # Define the ID's of the div blocks, that we update on the page
        chat_header = "chat_header_#{@user.id}"
        avatar_big = "avatar_big_#{@user.id}"
        user_avatar = "user_avatar_#{@user.id}"

        respond_to do |format|
            format.turbo_stream { render "avatar/remove_image", 
                locals: {avatar: "avatar_#{@user.id}", instance_avatar: user_avatar, instance: @user, partial: "users/user",  
                chat_header:, avatar_big:, user_avatar:, flash_notice: "Cover image was successfully removed from your data!"}
            }           

            # format.html {redirect_to edit_user_path(@user) }
        end
    end

    private
    def set_user
        @user = User.find(params[:user_id]) if user_signed_in? 
    end
end