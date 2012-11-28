class HorsesController < ApplicationController
  # GET user/:user_id/horses
  # GET user/:user_id/horses.json
  def index
      @user = User.find(params[:user_id])
      @horse = @user.horses.all

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
  
  def new
    @user = User.find(params[:user_id])
    @horse = @user.horses.new
  end

  # POST user/:user_id/horses
  # POST user/:user_id/horses.json
  def create
      @user = User.find(params[:user_id])
      @horse = @user.horses.build(params[:horse])
       
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

  # DELETE user/:user_id/horses/1
  # DELETE user/:user_id/horses/1.json
  def destroy
      @user = User.find(params[:user_id])
      @horse = @user.horses.find(params[:id])
      @horse.destroy  
      redirect_to user_horses_path(@user)
  end
end
