class CustomersController < ApplicationController
    def create 
        Stripe.api_key = ENV['STRIPE_API_KEY']
        @user = current_user
        @customer = @user.build_customer(:stripe_customer_token => @stripe_customer.id)
        @stripe_customer = Stripe::Customer.create(description: @user.email, card: params[:stripe_card_token])
    end
    
    def edit
        Stripe.api_key = ENV['STRIPE_API_KEY']
        @user = current_user
        @customer = @user.customer    
        stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        stripe_customer.card = params[:stripe_card_token]
        stripe_customer.save
    end
    
    def destroy
        Stripe.api_key = ENV['STRIPE_API_KEY']
        @user = User.find(params[:user_id])
        @customer = @user.customer
        @stripe_customer = Stripe::Customer.retrieve(@customer.stripe_customer_token)
        @stripe_customer.cancel_subscription        
        @customer.destroy
        
        respond_to do |format|
            format.html { redirect_to user_path(@user) }
            format.json { head :no_content }
        end
    end
end
