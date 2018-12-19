class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "messages_#{message.dig(:json_version, :conversation_id)}", {
    	message: render_message(message)
    }
  end

  private

  def render_message(message)
     {
         template: MessagesController.render(
             partial: 'message',
             locals: {
                 message: message[:template_version]
             }
         ),
         json_version: message[:json_version].to_json
     }
  end
end
