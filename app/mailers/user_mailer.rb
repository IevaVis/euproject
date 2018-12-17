class UserMailer < ApplicationMailer

	default from: "mediusgroupproject@gmail.com"

	def welcome_email
    @user = params[:user]
    attachments.inline["Logo.png"] = File.read("#{Rails.root}/app/assets/images/Logo.png")
    mail(to: @user.email, subject: "Welcome to Createskills Platform")
  end
  
end
