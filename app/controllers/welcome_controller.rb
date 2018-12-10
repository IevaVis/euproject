class WelcomeController < ApplicationController
	
  
  def index
	end

	def terms
		add_breadcrumb "Home", :root_path
		add_breadcrumb "Terms"
	end

end