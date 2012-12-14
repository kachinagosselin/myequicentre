class ContactsController < ApplicationController
    
    def destroy
        @user = User.find(params[:user_id])
        @contact = @user.contacts.find(params[:id])
        @contact.destroy
        
        respond_to do |format|
            format.html { redirect_to user_contacts_path(@user) }
            format.json { head :no_content }
        end
    end
end
