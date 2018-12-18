class Diyproject < ApplicationRecord
	ratyrate_rateable 'difficulty_degree'
	belongs_to :user
	has_many_attached :images
	validates :title, presence: true, length: { maximum: 100}
	validates :description, presence: true, length: { maximum: 1000}
	validates :age, :place,  presence: true
	validates_acceptance_of :terms, :allow_nil => false,
  :accept => true
  validates :objective, presence: true, length: { maximum: 500}
  validates :duration, presence: true, length: { maximum: 50}
  validates :materials, presence: true, length: { maximum: 500}
  validates :results_and_tips, presence: true, length: { maximum: 1000}
  validates :links_and_resources, presence: true, length: { maximum: 500}
  validates :tags, presence: true
  validate :max_tag_size
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

	def max_tag_size
 		errors[:diyprojects] << ": add minimum 1 and maximum 5 keywords separated by commas" if tags.count > 5
 		self.tags.each do |tag|
  		errors[:diyprojects] << ": Keywords have to be 15 characters maximum each and each keyword has to be separated by comma" if tag.length > 15
 		end
	end
end
