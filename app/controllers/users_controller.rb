class UsersController < ApplicationController
  before_filter :authenticate_user!
      
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
   @user = User.find(params[:id])
    if @user == current_user
    else
    authorize! :index, @user, :message => 'You are not authorized to view this page.'
    end
  end
    
  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator'
    user = User.find(params[:id])
    gb.list_unsubscribe(:id => list_id, :email_address => user.email, :delete_member => true, :send_goodbye => false, :send_notify => false)
      
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end