class DiyprojectsController < ApplicationController
	before_action :set_diyproject, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	add_breadcrumb "Home", :root_path
	add_breadcrumb "DIY List", :diyprojects_path

	def index
		if I18n.locale == :en
		@diyprojects = Diyproject.where(diy_language: "English").paginate(:page => params[:page], per_page: 16).order('created_at DESC')
		end
		if I18n.locale == :pt
		@diyprojects = Diyproject.where(diy_language: "Portuguese").paginate(:page => params[:page], per_page: 16).order('created_at DESC')
		end
		if I18n.locale == :lt
		@diyprojects = Diyproject.where(diy_language: "Lithuanian").paginate(:page => params[:page], per_page: 16).order('created_at DESC')
		end
		if I18n.locale == :es
		@diyprojects = Diyproject.where(diy_language: "Spanish").paginate(:page => params[:page], per_page: 16).order('created_at DESC')
		end
		if I18n.locale == :gr
		@diyprojects = Diyproject.where(diy_language: "Greek").paginate(:page => params[:page], per_page: 16).order('created_at DESC')
		end
		@diyprojects = Diyproject.diy_language(params[:diy_language]).paginate(:page => params[:page], per_page: 16).order('created_at DESC') if params[:diy_language].present?
  	@diyprojects = @diyprojects.place(params[:place]).paginate(:page => params[:page], per_page: 16).order('created_at DESC') if params[:place].present?
		@diyprojects = @diyprojects.age(params[:age]).paginate(:page => params[:page], per_page: 16).order('created_at DESC') if params[:age].present?
		respond_to do |format|
			format.html { 
				render "index"
			}
		end
	end

	def new
		add_breadcrumb "Upload new DIY project", :new_diyproject_path
		@diyproject = Diyproject.new
	end

	def create
		@diyproject = Diyproject.new(valid_params)
		@diyproject.user = current_user
		if @diyproject.save
			flash[:success] = t(:diy_uploaded)
			redirect_to diyprojects_path
		else 
			render:new
		end
	end

	def show
		add_breadcrumb "DIY images", :diyproject_path
		respond_to do |format|
   		format.html
   		format.pdf {render template: 'diyprojects/report', pdf: 'Report'}
  	end
	end

	def edit
	end

	def update
		if @diyproject.update_attributes(valid_params)
			redirect_to diyproject_path(@diyproject)
			flash[:success] = t(:diy_updated)
		else
			render :edit
		end
	end

	def destroy
		@diyproject.destroy
		redirect_to root_path
	end

  private
		def valid_params
			params.require(:diyproject).permit(:title, :description, :place, :age, :attachment, :terms, :diy_language)
		end

		def require_login
			if !signed_in?
				flash[:danger] = t(:require_login)
				redirect_to root_path
			end
		end

		def require_same_user
			if current_user != @diyproject.user
				flash[:danger] = "You can only edit or delete your own uploads"
			redirect_to diyprojects_path
			end
		end

		def set_diyproject
			@diyproject = Diyproject.find(params[:id])
		end
end