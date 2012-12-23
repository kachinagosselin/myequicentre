class HorsesController < ApplicationController
  # GET user/:user_id/horses
  # GET user/:user_id/horses.json
  def index
      @user = User.find(params[:user_id])
      @horse = @user.horses.all
      
      @search = Horse.search(params[:search])
      @horses = @search.all 
      
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: user_horses_path(@user) }
    end
  end

  # GET user/:user_id/horses/1
  # GET user/:user_id/horses/1.json
  def show
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
  end
  
  # GET user/:user_id/horses/new
  # GET user/:user_id/horses/new.json
  def new
    @user = User.find(params[:user_id])
    @horse = @user.horses.new
      
  end

  # POST user/:user_id/horses
  # POST user/:user_id/horses.json
  def create
      @user = User.find(params[:user_id])
      @horse = @user.horses.build(params[:horse])
      @horse.sale_status = "inactive"

    respond_to do |format|
      if @horse.save
        format.html { redirect_to user_horse_path(@user, @horse), notice: 'Horse was successfully created.' }
        format.json { head :no_content }
      else
        format.html { redirect_to user_horses_path(@user), alert: 'Horse was unsuccessfully created.' }
        format.json { render json: @message.errors, status: :unprocessable_entity }
     end 
    end
  end

  # GET user/:user_id/horses/1/edit
  def edit
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
  end
  
  def update
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
    respond_to do |format|
        if @horse.update_attributes(params[:horse])
        format.html { redirect_to user_horse_path(@user, @horse), notice: 'Horse was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end
    
  def search
      @search = Horse.search(params[:search])
      @horses = @search.paginate(:page => params[:page], :per_page => 9)
  end

  def changestatus
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
      if @horse.status == "disabled"
      @horse.update_attribute(:status, "normal")
      @horse.update_attribute(:flagged, "false")
      redirect_to users_path
      else
      @horse.update_attribute(:status, "disabled")
      @horse.update_attribute(:flagged, "true")
      redirect_to users_path
      end
  end

  def unflag
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
      @horse.update_attribute(:flagged, "false")
      redirect_to users_path
  end
    
  def flag
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
      @horse.update_attribute(:status, "flagged")
      @horse.update_attribute(:flagged, "true")
      redirect_to users_path
  end

  def destroy
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
      @subscription = @user.subscriptions.where(:horse_id => @horse.id).first
      if @subscription.present?
        @customer = @user.customer   
        #If customer and subscription
        if @customer.present?
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        number = stripe_customer.subscription.quantity
        #if there are multiple subscriptions then decrement count
            if number > 1
            new_number = number - 1  
            @horse.update_attribute(:sale_status, "inactive")
            @subscription.destroy
            stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
            stripe_customer.update_subscription(:plan => "001", :quantity => new_number)  
            else
            #if this is the last subscription, cancel the subscription
            @horse.update_attribute(:sale_status, "inactive")
            stripe_customer.cancel_subscription
            @subscription.destroy
            end
        end
      end
        @horse.destroy  
        redirect_to user_path(@user)
      end
  end