class DiyextraimagesController < ApplicationController


	def new
		@diyproject = Diyproject.find(params[:diyproject_id])
		@diyextraimage = Diyextraimage.new
	end

	def create
		@diyextraimage = Diyextraimage.new(diyextraimage_params)
		@diyextraimage.user = current_user
		@diyproject = Diyproject.find(params[:diyproject_id])
		@diyextraimage.diyproject_id = @diyproject.id
		if @diyextraimage.save
			flash[:success] = t(:document_uploaded)
			redirect_to diyproject_path(@diyproject)
		else 
			render :new
		end
	end


	private
	def diyextraimage_params
  	params.require(:diyextraimage).permit(:image)
	end

end
