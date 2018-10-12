class CommentsController < ApplicationController
	before_action :set_chatroom
	before_action :require_login
  
  def create
  	@comment = @chatroom.comments.new(valid_params)
  	@comment.user = current_user
  	@comment.save
  end

  private

  def valid_params
  	params.require(:comment).permit(:body, :chatroom_id)
  end

  def set_chatroom
  	@chatroom = Chatroom.find(params[:chatroom_id])
  end

  def require_login
		if !signed_in? or !current_user.teacher?
			flash[:danger] = "Only logged in teachers can perform this action"
			redirect_to root_path
		end
	end

end


