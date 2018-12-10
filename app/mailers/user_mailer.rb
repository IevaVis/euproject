class UserMailer < ApplicationMailer

	default from: "mediusgroupproject@gmail.com"

	def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: "Welcome to Createskills Platform")
  end
  
end
