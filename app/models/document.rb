class Document < ApplicationRecord
	belongs_to :user
	has_one_attached :attachment
	validates :title, presence: true, length: { maximum: 50}
  validates :description, presence: true, length: { maximum: 250}
	validates :is_public, inclusion: [true, false]
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true
  validates :doc_language, presence: true
  validate :attachment_type




  default_scope {where nil}
  scope :doc_language, -> (name) { where('doc_language iLIKE ?', "%" + name + "%") }
  scope :tags, -> (tags)  {where('documents.tags @> ARRAY[?]', [tags.capitalize])}


  def self.tag_search(tag)
    where("? = ANY(tags)", "#{tag}")
  end

  private

  def attachment_type
    if attachment.attached? == false
      errors[:attachment] << "is missing"
    end
    if attachment.attached? and !attachment.content_type.in?(%(image/jpg image/jpeg image/png application/pdf application/zip application/vnd.openxmlformats-officedocument.wordprocessingml.document))
      errors.add(:attachment, 'must be a PDF, DOC, JPG or PNG file')
    end
  end


end
