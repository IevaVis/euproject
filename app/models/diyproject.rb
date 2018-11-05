class Diyproject < ApplicationRecord
	ratyrate_rateable 'difficulty_degree'
	belongs_to :user
	has_many_attached :images
	validates :title, presence: true, length: { maximum: 50}
	validates :description, presence: true, length: { maximum: 500}
	validates :age, :place,  presence: true
	validate :image_type


  default_scope {where nil}
  scope :place, -> (name) { where('place iLIKE ?', "%" + name + "%") }
  scope :age, -> (name) { where('age iLIKE ?', "%" + name + "%") }


  private
	def image_type
		if images.attached? == false
			errors[:images] << "are missing"
		end
		images.each do |image|
			if !image.content_type.in?(%(image/jpg image/jpeg image/png'))
				errors[:images] << 'needs to be a JPG og PNG'
			end
		end
	end
end
