class TestimonialsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @testimonial = @user.testimonials.create(params[:testimonial])
        redirect_to user_horse_path(@user, @testimonial.horse_id)
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @testimonial = @user.testimonials.find(params[:id])
        @horse_id = @testimonial.horse_id
        @testimonial.destroy
        redirect_to user_horse_path(@user, @horse_id)
    end
end
