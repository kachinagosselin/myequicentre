class HorsesController < ApplicationController
  # GET user/:user_id/horses
  # GET user/:user_id/horses.json
  def index
      @user = User.find(params[:user_id])

      @horses = Horse.where(:user_id => @user.id, :active => true).paginate(:page => params[:page], :per_page => 3)

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
      @horse.active = false

    respond_to do |format|
      if @horse.save
        format.html { redirect_to user_path(@user), notice: 'Horse was successfully created.' }
        format.json { head :no_content }
      else
        format.html { render :action => 'new', alert: 'Horse was unsuccessfully created.' }
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
    if params.has_key?(:search)
        tmp_values = { "gender_contains_any" => params[:search][:gender_contains_any], 
        "gender_contains" => params[:search][:gender_contains],
        "breed_contains_any" => params[:search][:breed_contains_any],
        "breed_contains" => params[:search][:breed_contains],
        "distance" => params[:search][:distance] }
        puts "*************SAVED TMP VALUES****************"
    end
    
    if params.has_key?(:search) && params[:search][:distance] != ""

     @keywords = params[:search][:name_or_breed_or_gender_or_text_description_contains_any]
     @keyword_array = @keywords.split(" ")
     params[:search][:name_or_breed_or_gender_or_text_description_contains_any] = @keyword_array

     @distance = params[:search][:distance]
     params[:search].delete :distance

    if params[:search][:breed_contains_any].blank?
     params[:search].delete :breed_contains_any
    else
     @breeds = params[:search][:breed_contains_any]
     @breed_array = @breeds.split(" ")
     params[:search][:breed_contains_any] = @breed_array
    end

    if params[:search][:gender_contains_any].blank?
     params[:search].delete :gender_contains_any
    else
     params[:search].delete :gender_contains
     @genders = params[:search][:gender_contains_any]
     @gender_array = @genders.split(" ")
     params[:search][:gender_contains_any] = @gender_array
    end

     @search = Horse.near(current_user.gmaps4rails_address, @distance).search(params[:search])
    elsif params.has_key?(:search)
     @keywords = params[:search][:name_or_breed_or_gender_or_text_description_contains_any]
     @keyword_array = @keywords.split(" ")
     params[:search][:name_or_breed_or_gender_or_text_description_contains_any] = @keyword_array

     params[:search].delete :distance

    if params[:search][:breed_contains_any].blank?
     params[:search].delete :breed_contains_any
    else
     @breeds = params[:search][:breed_contains_any]
     @breed_array = @breeds.split(" ")
     params[:search][:breed_contains_any] = @breed_array
    end

    if params[:search][:gender_contains_any].blank?
     params[:search].delete :gender_contains_any
    else
     params[:search].delete :gender_contains
     @genders = params[:search][:gender_contains_any]
     @gender_array = @genders.split(" ")
     params[:search][:gender_contains_any] = @gender_array
    end

     @search = Horse.search(params[:search])    
   else
     @search = Horse.search(params[:search])
   end
   
   if params.has_key?(:search)
      params[:search] = params[:search].merge(tmp_values)  
              puts "**************ASSIGNED TMP VALUES***************"
      puts params[:search]
   end
   
      @horses = @search.paginate(:page => params[:page], :per_page => 9)
      #@json = @horses.to_gmaps4rails
      
      @json = @horses.where(:active => true).to_gmaps4rails do |horse, marker|
        marker.infowindow render_to_string(:partial => "/horses/display_marker", :locals => {:object => horse})
        #marker.title   horse.name
        #marker.sidebar "i'm the sidebar"
        #marker.json({ :id => @horse.id })
      end
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
      Stripe.api_key
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
            @horse.update_attribute(:active, false)
            stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
            stripe_customer.update_subscription(:plan => @subscription.plan_id, :quantity => new_number)  
            else
            #if this is the last subscription, cancel the subscription
            @horse.update_attribute(:active, false)
            stripe_customer.cancel_subscription
            end
        end
      end
        @horse.destroy  
        redirect_to user_path(@user)
      end
  end