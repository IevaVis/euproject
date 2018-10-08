class DiyprojectsController < ApplicationController
	before_action :set_diyproject, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:index, :new, :create, :edit, :update, :destroy]

	def index
		@diyprojects = Diyproject.all
		if params[:age]
      @diyprojects = Diyproject.age_search(params[:age])
    elsif params[:place]
    	@diyprojects = Diyproject.place_search(params[:place])
    else
      @diyproject = Diyproject.all
    end

	end

	def new
		@diyproject = Diyproject.new
	end

	def create
		@diyproject = Diyproject.new(valid_params)
		@diyproject.user = current_user
		if @diyproject.save
			flash[:success] = "Thank You! Your project is uploaded successfully!"
			redirect_to diyproject_path(@diyproject)
		else 
			flash[:danger] = "Something went wrong. Try again."
			render:new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @diyproject.update_attributes(valid_params)
			redirect_to diyproject_path(@diyproject)
			flash[:success] = "DIY project updated successfully"
		else
			flash[:alert] = "Error updating DIY Project. Try again"
			render :edit
		end
	end

	def destroy
		@diyproject.destroy
		redirect_to root_path
	end

  private
		def valid_params
			params.require(:diyproject).permit(:title, :description, :place, :age)
		end

		def require_login
			if !signed_in?
				flash[:danger] = "You must be logged in to continue!"
				redirect_back(fallback_location: root_path)
			end
		end

		def set_diyproject
			@diyproject = Diyproject.find(params[:id])
		end
end