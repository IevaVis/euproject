class Document < ApplicationRecord
	belongs_to :user
	has_one_attached :attachment
	validates :title, presence: true, length: { maximum: 50}
  validates :description, presence: true, length: { maximum: 250}
	validates :is_public, inclusion: [true, false]
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true
  validates :doc_language, presence: true
  validates :tags, presence: true
  validate :attachment_type
  validate :max_tag_size




  default_scope {where nil}
  scope :doc_language, -> (name) { where('doc_language iLIKE ?', "%" + name + "%") }
  scope :tags, -> (tags)  {where('documents.tags @> ARRAY[?]', [tags.capitalize])}


  def self.tag_search(tag)
    where("? = ANY(tags)", "#{tag}")
  end

  private

  
def max_tag_size
 errors[:documents] << ": add minimum 1 and maximum 5 keywords separated by commas" if tags.count > 5
 self.tags.each do |tag|
  errors[:documents] << ": Keywords have to be 15 characters maximum each and each keyword has to be separated by comma" if tag.length > 15
 end
end

  def attachment_type
    if attachment.attached? == false
      errors[:attachment] << "is missing"
    end
    if attachment.attached? and !attachment.content_type.in?(%(image/jpg image/jpeg image/png application/pdf application/zip application/vnd.openxmlformats-officedocument.wordprocessingml.document))
      errors.add(:attachment, 'must be a PDF, DOC, JPG or PNG file')
    end
  end


end
