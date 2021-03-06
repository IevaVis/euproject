class MessagesController < ApplicationController
	before_action :set_conversation
	before_action :require_login
	before_action :require_conversation_users

	def index
		@messages = @conversation.messages.order(created_at: :asc)
		@messages.where("user_id != ? AND read = ?", current_user.id, false).update_all(read: true)
		@message = @conversation.messages.new
	end

	def create
		@message = @conversation.messages.new(message_params)
		@message.user = current_user
		files = params[:message][:files]
		if @message.save
			if files
				@message.files.attach
			end
			if @conversation.sender == current_user
       	Notification.create(receiver: @conversation.recipient, actor: @conversation.sender, action: "sent", notifiable: @message)
     	elsif @conversation.recipient == current_user
     		Notification.create(receiver: @conversation.sender, actor: @conversation.recipient, action: "sent", notifiable: @message)
     	end
			redirect_to conversation_messages_path(@conversation)
		end
	end



	def new
		@message = @conversation.messages.new
	end

	private

	def message_params
		params.require(:message).permit(:body, :user_id, files: [])
	end

	def set_conversation
		@conversation = Conversation.find(params[:conversation_id])
	end

	def require_login
		if !signed_in? or !current_user.teacher?
			flash[:danger] = t(:require_logged_teacher)
			redirect_back(fallback_location: root_path)
		end
	end

	def require_conversation_users
		if (current_user != @conversation.recipient) and (current_user != @conversation.sender)
			flash[:danger] = t(:conversation_not_found)
			redirect_back(fallback_location: root_path)
		end
	end
end
