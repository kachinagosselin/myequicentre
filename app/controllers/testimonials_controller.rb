class TestimonialsController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        @testimonial = @user.testimonials.create(params[:testimonial])
        if @testimonial.save
            if @testimonial.horse_id.present?
                redirect_to user_horse_path(@user, @testimonial.horse_id)
                else
                redirect_to user_horses_path(@user)
            end
        else
            if @testimonial.horse_id.present?
                redirect_to user_horse_path(@user, @testimonial.horse_id)
            else
                redirect_to user_horses_path(@user)
            end            
        end 
    end
    
    def destroy
        @user = User.find(params[:user_id])
        @testimonial = @user.testimonials.find(params[:id])
        @horse_id = @testimonial.horse_id
        @testimonial.destroy
        if @horse_id.present?
            redirect_to user_horse_path(@user, @horse_id)
            else
            redirect_to user_horses_path(@user)
        end
    end
end


