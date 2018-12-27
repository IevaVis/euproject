class NotificationsController < ApplicationController
	before_action :require_login

	def index
		@notifications = Notification.where(receiver: current_user).unread.order("created_at DESC")
	end

	def mark_as_read
		@notifications = Notification.where(receiver: current_user).unread
		@notifications.update_all(read_at: Time.zone.now)
		render json: {success: true}
	end


	private

	def require_login
		if !signed_in? or !current_user.teacher?
			flash[:danger] = t(:require_logged_teacher)
			redirect_back(fallback_location: root_path)
		end
	end

end
