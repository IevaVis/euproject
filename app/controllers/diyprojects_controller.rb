class DiyprojectsController < ApplicationController
	before_action :set_diyproject, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:index, :new, :create, :edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
	add_breadcrumb "Home", :root_path
	add_breadcrumb "DIY List", :diyprojects_path

	def index
		@diyprojects = Diyproject.paginate(:page => params[:page], per_page: 15).order('created_at DESC')
  	@diyprojects = Diyproject.place(params[:place]).paginate(:page => params[:page], per_page: 15).order('created_at DESC') if params[:place].present?
		@diyprojects = @diyprojects.age(params[:age]).paginate(:page => params[:page], per_page: 15).order('created_at DESC') if params[:age].present?
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
			if !params[:diyproject][:tags].blank?
        params[:diyproject][:tags] = params[:diyproject][:tags].split(",")
        params[:diyproject][:tags].each_with_index do |tag, index|
          params[:diyproject][:tags][index] = tag.strip.titleize
        end
      end
				params.require(:diyproject).permit(:title, :description, :place, :age, :terms, :objective, :duration, :materials, :results_and_tips, :links_and_resources, :tags => [], images: [])
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