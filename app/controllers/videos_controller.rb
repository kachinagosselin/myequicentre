class VideosController < ApplicationController
    def index
        @horse = Horse.find(params[:horse_id])
    end 
    
    def create
        puts params
        @horse = Horse.find(params[:horse_id])
        @video = @horse.videos.build(params[:video])
        if @video.save
            redirect_to edit_user_horse_path(@horse.user, @horse)
            else
            render :action => 'new'
        end
    end
    
    def destroy
        @horse = Horse.find(params[:horse_id])
        @video = @horse.videos.find(params[:id])
        @horse_id = @video.horse_id
        @video.destroy
        redirect_to edit_user_horse_path(@horse.user, @horse)
    end
end
