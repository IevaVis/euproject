class Document < ApplicationRecord
	belongs_to :user
	has_one_attached :attachment
	validates :title, :tags, presence: true
	validates :is_public, inclusion: [true, false]
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true


  default_scope {where nil}
  scope :doc_language, -> (name) { where('doc_language iLIKE ?', "%" + name + "%") }
  scope :tags, -> (tags)  {where('documents.tags @> ARRAY[?]', [tags.capitalize])}


  def self.tag_search(tag)
    where("? = ANY(tags)", "#{tag}")
  end

end
