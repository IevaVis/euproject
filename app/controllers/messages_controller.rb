class MessagesController < ApplicationController
	before_action :set_conversation
	before_action :require_login

	def index
		@messages = @conversation.messages

		if @messages.length > 10
			@over_ten = true
			@messages = @messages[-10..-1]
		end

		if params[:m]
			@over_ten = false
			@messages = @conversation.messages
		end

		@message = @conversation.messages.new
	end

	def create
		@message = @conversation.messages.new(message_params)
		if @message.save
			redirect_to conversation_messages_path(@conversation)
		end
	end

	def new
		@message = @conversation.messages.new
	end

	private

	def message_params
		params.require(:message).permit(:body, :user_id)
	end

	def set_conversation
		@conversation = Conversation.find(params[:conversation_id])
	end

	def require_login
		if !signed_in? or !current_user.teacher?
			flash[:danger] = "Only logged in teachers can perform this action"
			redirect_back(fallback_location: root_path)
		end
	end
end
