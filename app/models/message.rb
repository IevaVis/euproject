class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user
  validates_presence_of :conversation_id, :user_id
  validates :body, presence: true, unless: Proc.new { |message| message.files.present? }
  has_many_attached :files
  validate :file_type

  after_create_commit {
    MessageBroadcastJob.perform_later(
      {
          json_version:
              {
                   from: self.user.name,
                   body: self.body,
                   created_at: self.message_time
          },
          template_version: self
      }
    )
  }

  # def check_empty_message
  #   if self.body.blank? && self.files
  #
  #   end
  # end

  def message_time
    created_at.strftime("%d-%m-%y at %l:%M %p")
  end

  private
  def file_type
    files.each do |file|
      if !file.content_type.in?(%(application/pdf application/zip application/vnd.openxmlformats-officedocument.wordprocessingml.document))
        errors.add(:files, 'Must be a PDF or a DOC file')
      end
    end
  end

end
