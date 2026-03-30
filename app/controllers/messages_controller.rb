class MessagesController < ApplicationController
   def create

        messageable = Room.find_by(id: params[:room_id]) || Group.find_by(id: params[:group_id])

        if messageable
            @message = messageable.messages.build(
                body: params[:message][:body],
                user_id: current_user.id,
                # attachments: message_params[:attachments]
                )

            if @message.save
                
                @display_delButton = (@message.user_id == current_user.id) ? true : false                   
           
                # Add Delete Button to the current_user chat room/group
                Turbo::StreamsChannel.broadcast_replace_to(
                    "user_#{current_user.id}_channel",
                    target: "message_#{@message.id}",
                    partial: "messages/message",
                    locals: {
                    message: @message,
                    delButton: @display_delButton
                    }
                )                 

            else
                flash[:danger] = @message.errors.full_messages.join(", ")
                redirect_back(fallback_location: root_path)
               
            end
        else
            flash[:alert] = "A message cannot be created"
            redirect_back fallback_location: root_path
        end       
    end
    
    def destroy
      begin 
        message = Message.find(params[:id])
        message.destroy if message
      rescue
        ActiveRecord::RecordNotFound
        flash[:error] = "Message doesn't exist "
      end
    end
end
