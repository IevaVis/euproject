class DocumentsController < ApplicationController
	before_action :set_document, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

	def index
		@documents = Document.all.order("created_at DESC")
	end

	def new
		@document = Document.new
	end

	def create
		@document = Document.new(valid_params)
		@document.user = current_user.teacher
		if @document.save
			flash[:success] = "Thank You! Your file is uploaded successfully!"
			redirect_to document_path(@document)
		else 
			flash[:danger] = "Something went wrong. Try again"
			render:new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @document.update_attributes(valid_params)
			redirect_to document_path(@document)
			flash[:success] = "File updated successfully"
		else
			flash[:alert] = "Error updating file. Try again"
			render :edit
		end
	end

	def destroy
		@document.destroy
			redirect_to documents_path
	end

  private
		def valid_params
			params.require(:document).permit(:title, :tags, :doc_language, :is_public)
		end

		def require_login
			if !signed_in? && !current_user.teacher?
				flash[:danger] = "Only logged in teachers can perform this action"
				redirect_back(fallback_location: root_path)
			end
		end

		def set_document
			@document = Document.find(params[:id])
		end
end