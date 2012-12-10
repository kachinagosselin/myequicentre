class SavedHorsesController < ApplicationController
    def new
        @user = User.find(params[:user_id])
        @saved_horse = @user.saved_horses.new
        @saved_horse.horse_id = params[:format]
        @saved_horse.saved = true
        @saved_horse.save
        redirect_to user_path(@user)
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @saved_horse = @user.saved_horses.find(params[:id])
        @saved_horse.destroy
        redirect_to user_path(@user)
    end
end
