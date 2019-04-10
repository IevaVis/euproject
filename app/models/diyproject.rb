class Diyproject < ApplicationRecord
	ratyrate_rateable 'difficulty_degree'
	belongs_to :user
	has_many :diyextraimages, dependent: :destroy
	has_one_attached :attachment
	validates :title, presence: true, length: { maximum: 100}
	validates :description, presence: true, length: { maximum: 1000}
	validates :age, :place,  presence: true
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true
	validate :attachment_type


  default_scope {where nil}
  scope :diy_language, -> (name) { where('diy_language iLIKE ?', "%" + name + "%") }
  scope :place, -> (name) { where('place iLIKE ?', "%" + name + "%") }
  scope :age, -> (name) { where('age iLIKE ?', "%" + name + "%") }


  private

	def attachment_type
		if attachment.attached? == false
			errors[:attachment] << "is missing"
		end
		if attachment.attached? and !attachment.content_type.in?(%(application/pdf))
      errors[:attachment] << I18n.t('wrong_attachment_type')
    end
	end
end
