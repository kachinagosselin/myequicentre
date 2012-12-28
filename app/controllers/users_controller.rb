class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
    @json = User.all.to_gmaps4rails
  end

  def show
   @user = User.find(params[:id])
   @horses = Horse.where(:user_id => @user.id, :active => true).paginate(:page => params[:page], :per_page => 3)
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
Stripe.api_key = ENV['STRIPE_API_KEY']
    authorize! :destroy, @user, :message => 'Not authorized as an administrator'
    user = User.find(params[:id])
      
    unless user == current_user
        @customer = user.customer
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        stripe_customer.cancel_subscription        
        user.destroy
        redirect_to users_path, :notice => "User deleted."
    else
        redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
    
  def changestatus
    authorize! :changestatus, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    if user.status == "disabled"
       user.update_attribute(:status, "normal")
       user.update_attribute(:flagged, "false")
       redirect_to users_path
    else
       user.update_attribute(:status, "disabled")
       user.update_attribute(:flagged, "true")
       redirect_to users_path
    end
  end
    
end