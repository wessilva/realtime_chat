class ContactsController < ApplicationController
  def index 
    @users = current_user.added_users
    @groups = current_user.added_groups
  end

   def create
        contact = User.find(params[:user_id])
        
        if current_user.added_users.exists?(contact.id)
          redirect_to user_contacts_path(current_user), alert: "#{contact.email} is already in your contacts."
        else
          current_user.added_users << contact
          contact.added_users << current_user # Optional: Make the association reciprocal
  
          redirect_to user_contacts_path(current_user), notice: "#{contact.email} was successfully added to your contacts."
        end
    end
  
    def destroy  

        contact = User.find(params[:id])
    
        if current_user.added_users.exists?(contact.id)
          current_user.added_users.delete(contact)
          # Optionally make the removal reciprocal
          contact.added_users.delete(current_user)  

  
          redirect_to user_contacts_path(current_user), notice: "#{contact.email} was successfully removed from your contacts."
        else
          redirect_to user_contacts_path(current_user), alert: "#{contact.email} is not in your contacts."
        end
    end
end
