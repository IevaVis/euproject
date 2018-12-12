class Conversation < ApplicationRecord
	belongs_to :sender, foreign_key: :sender_id, class_name: "User"
	belongs_to :recipient, foreign_key: :recipient_id, class_name: "User"
	has_many :messages, dependent: :destroy
	validates_uniqueness_of :sender_id, scope: :recipient_id
	has_one :last_message, -> { order(created_at: :desc) }, class_name: "Message"

	scope :between, -> (sender_id, recipient_id) do
		where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
	end

	def unread_message_count(current_user)
    self.messages.where("user_id != ? AND read = ?", current_user.id, false).count
  end
  
end
