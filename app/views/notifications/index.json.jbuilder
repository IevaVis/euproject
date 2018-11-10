json.array! @notifications do |notification|
	json.id notification.id
	json.actor notification.actor.name
	json.action notification.action
	json.notifiable do
		json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"

	end

	json.url chatroom_path(notification.notifiable.chatroom, anchor: dom_id(notification.notifiable)) 


end


# json.array! @notifications do |notification|
# 	json.id notification.id
# 	json.actor notification.actor.name
# 	json.action notification.action
# 	json.notifiable do
# 		json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"

# 	end

# 	json.url conversation_messages_path(notification.notifiable.conversation, anchor: dom_id(notification.notifiable)) 

# end
