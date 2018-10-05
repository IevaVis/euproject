class Document < ApplicationRecord
	belongs_to :user
	has_one_attached :attachment
	validates :title, :tags, presence: true
	validates :is_public, inclusion: [true, false]
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true

  def self.search(search)
  	where("title ILIKE ?",  "%#{search}%" )
  end

  def self.tag_search(tag)
    where("? = ANY(tags)", "#{tag}")
  end
end
