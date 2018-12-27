class DocumentsController < ApplicationController
	before_action :set_document, only: [:show, :edit, :update, :destroy]
	before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
	before_action :require_login_for_viewing, only: [:index]
	add_breadcrumb "Home", :root_path


	def index
		add_breadcrumb "Library", documents_path
  	@documents = Document.all.order('created_at DESC')
		@tags = @documents.map {|document| document.tags}.flatten.uniq
    if params[:tag]
      @documents = Document.tag_search(params[:tag]).order('created_at DESC')
    end
  	@documents = Document.doc_language(params[:doc_language]).order('created_at DESC') if params[:doc_language].present?
		@documents = @documents.tags(params[:tags]).order('created_at DESC') if params[:tags].present?
		respond_to do |format|
			format.html { 
				render "index"
			}
		end
	end

	def new
		add_breadcrumb "Upload new document"
		@document = Document.new
	end

	def create
		@document = Document.new(valid_params)
		@document.user = current_user
		if @document.save
			flash[:success] = t(:document_uploaded)
			redirect_to documents_path
		else 
			render :new
		end
	end

	def show
	end

	def edit
	end

	def update
		if @document.update_attributes(valid_params)
			redirect_to document_path(@document)
			flash[:success] = t(:information_updated)
		else
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
      params.require(:document).permit(:title, :description, :doc_language, :is_public, :terms, :attachment, :tags => [])
    end

		def require_login
			if !signed_in? or !current_user.teacher?
				flash[:danger] = t(:require_logged_teacher)
				redirect_back(fallback_location: root_path)
			end
		end

		def require_login_for_viewing
			if !signed_in?
				flash[:danger] = t(:require_login_for_viewing)
				redirect_back(fallback_location: root_path)
			end
		end

		def set_document
			@document = Document.find(params[:id])
		end
end