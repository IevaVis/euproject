class DocumentsController < ApplicationController
	before_action :set_document, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :require_login_for_viewing, only: [:index]



	def index
  	@documents = Document.all
		@tags = @documents.map {|document| document.tags}.flatten.uniq
    if params[:tag]
      @documents = Document.tag_search(params[:tag])
    end
  	@documents = Document.doc_language(params[:doc_language]) if params[:doc_language].present?
		@documents = @documents.tags(params[:tags]) if params[:tags].present?
		respond_to do |format|
			format.html { 
				render "index"
			}
		end
	end

	def new
		@document = Document.new
	end

	def create
		@document = Document.new(valid_params)
		@document.user = current_user
		if @document.save
			flash[:success] = "Thank You! Your file is uploaded successfully!"
			redirect_to documents_path
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
      if !params[:document][:tags].blank?
        params[:document][:tags] = params[:document][:tags].split(",")
        params[:document][:tags].each_with_index do |tag, index|
          params[:document][:tags][index] = tag.strip.titleize
        end
      end
      params.require(:document).permit(:title, :doc_language, :is_public, :terms, :attachment, :tags => [])
    end

		def require_login
			if !signed_in? or !current_user.teacher?
				flash[:danger] = "Only logged in teachers can perform this action"
				redirect_back(fallback_location: root_path)
			end
		end

		def require_login_for_viewing
			if !signed_in?
				flash[:danger] = "You have to be logged in to view the library!"
				redirect_back(fallback_location: root_path)
			end
		end

		def set_document
			@document = Document.find(params[:id])
		end
end