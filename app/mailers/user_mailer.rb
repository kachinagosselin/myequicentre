class UserMailer < ActionMailer::Base
    default from: "notifications@myequicentre.com"
    
    def welcome_email(user)
        @user = user
        @url  = "http://www.myequicentre.com/sign_in"
        mail(:to => user.email, :subject => "Welcome to EquiCentre!")
    end
    
end
