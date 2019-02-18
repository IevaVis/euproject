class WelcomeController < ApplicationController
	
  
  def index
	end

	def terms
		add_breadcrumb t(".home"), :root_path
		add_breadcrumb "Terms"
	end

	def about
		add_breadcrumb t(".home"), :root_path
		add_breadcrumb "About Us"
	end

	def contacts
		add_breadcrumb t(".home"), :root_path
		add_breadcrumb "Contacts"
	end

end