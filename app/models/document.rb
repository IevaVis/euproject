class Document < ApplicationRecord
	belongs_to :user
	has_one_attached :attachment
	validates :title, presence: true, length: { maximum: 100}
  validates :description, presence: true, length: { maximum: 500}
	validates :is_public, :inclusion => {:in => [true, false]}
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
 errors[:tags] << I18n.t('too_many_tags') if tags.count > 5
 self.tags.each do |tag|
  errors[:tags] << I18n.t('wrong_tags_length')if tag.length > 20
 end
end

  def attachment_type
    if attachment.attached? == false
      errors[:attachment] << I18n.t('attachment_missing')
    end
    if attachment.attached? and !attachment.content_type.in?(%(image/jpg image/jpeg image/png application/pdf application/msword application/zip application/vnd.openxmlformats-officedocument.wordprocessingml.document))
      errors[:attachment] << I18n.t('wrong_attachment_type')
    end
  end


end
