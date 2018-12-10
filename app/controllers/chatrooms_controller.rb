class ChatroomsController < ApplicationController
	before_action :set_chatroom, only: [:show, :edit, :update, :destroy]
	before_action :require_teacher_login, only: [:index, :new, :show, :create, :edit, :update, :destroy]
	add_breadcrumb "Home", :root_path
	add_breadcrumb "Teachers' Forum", :chatrooms_path

	def index
		@chatrooms = Chatroom.all.order('created_at DESC')
		@chatroom = Chatroom.new
		@comments = Comment.all

	end

	def new
		@chatroom = Chatroom.new
	end

	def create
		@chatroom = Chatroom.new(valid_params)
		@chatroom.user = current_user
		if @chatroom.save
		redirect_to chatrooms_path
		else
		render 'new'
		end 
	end

	def show
		add_breadcrumb "Forum Post & Comments", :chatroom_path
		@comment = Comment.new
		@comments = @chatroom.comments.order('created_at DESC')
	end

	def edit
	end

	def update
		if @chatroom.update_attributes(valid_params)
			redirect_to chatroom_path(@chatroom)
			flash[:success] = "Updated successfully"
		else
			flash[:alert] = "Error updating chat. Try again"
			render :edit
		end
	end

	def destroy
		@chatroom.destroy
		redirect_to root_path
	end

	private

	def valid_params
		params.require(:chatroom).permit(:title, :description)
	end

	def set_chatroom
		@chatroom = Chatroom.find(params[:id])
	end

	def require_teacher_login
		if !signed_in? or !current_user.teacher?
				redirect_to root_path
				flash[:danger] = "Only logged in teachers can perform this action"
			end
	end

end