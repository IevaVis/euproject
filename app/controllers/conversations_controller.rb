class ConversationsController < ApplicationController
	before_action :require_login



	def index
		@conversations = Conversation.all.includes(:last_message)
	end

	def create
		if Conversation.between(params[:sender_id], params[:recipient_id]).present?
			@conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
		else
			@conversation = Conversation.create!(conversation_params)
		end
		redirect_to conversation_messages_path(@conversation)
	end


private

	def conversation_params
		params.permit(:sender_id, :recipient_id)
	end


	def require_login
		if !signed_in? and !current_user.teacher? 
			flash[:danger] = "Only logged in teachers can perform this action"
			redirect_back(fallback_location: root_path)
		end
	end

end