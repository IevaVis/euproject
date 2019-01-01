class ChatroomsController < ApplicationController
	before_action :set_chatroom, only: [:show, :edit, :update, :destroy]
	before_action :require_teacher_login, only: [:index, :new, :show, :create, :edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]
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
		@comments = @chatroom.comments
	end

	def edit
	end

	def update
		if @chatroom.update_attributes(valid_params)
			redirect_to chatroom_path(@chatroom)
			flash[:success] = t(:information_updated)
		else
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

	def require_same_user
		if current_user != @chatroom.user
			flash[:danger] = "You can only edit or delete your own forum posts"
		redirect_to chatrooms_path
		end
	end

	def require_teacher_login
		if !signed_in? or !current_user.teacher?
				redirect_to root_path
				flash[:danger] = t(:require_logged_teacher)
			end
	end

end