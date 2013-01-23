class FarmsController < ApplicationController
    def show
        @farm = Farm.find(params[:id])
        @json = @farm.to_gmaps4rails
    end
    
    def new
        @user = current_user if current_user
        @farm = Farm.new
    end
    
    def create
        @user = current_user if current_user
        @farm = Farm.create(params[:farm])
        
        respond_to do |format|
            if @farm.save
                format.html { redirect_to user_path(@user), notice: 'Farm was successfully created.' }
                format.json { head :no_content }
                else
                format.html { render :action => 'new', alert: 'Farm was unsuccessfully created.' }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end 
        end
    end
    
    # GET user/:user_id/horses/1/edit
    def edit
        @user = current_user if current_user
        @farm = Farm.find(params[:id])
    end
    
    def update
        @user = current_user if current_user
        @farm = Farm.find(params[:id])
        
        respond_to do |format|
            if @farm.update_attributes(params[:farm])
                format.html { redirect_to farm_path(@farm), notice: 'Farm was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render action: "edit" }
                format.json { render json: @message.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def search
        #if params.has_key?(:search) && params[:search][:distance] != ""    
        #    @search = Farm.near(current_user.gmaps4rails_address, @distance).search(params[:search])
        if params.has_key?(:search)
            #params[:search].delete :distance
            @search = Farm.search(params[:search])
        else
            @search = Farm.search(params[:search])
        end
        
        @farms = @search.paginate(:page => params[:page], :per_page => 9)        
        @json = @farms.to_gmaps4rails
    end
    
    def destroy
        @farm = Farm.find(params[:id])
        @farm.destroy
        redirect_to :back
    end
end
