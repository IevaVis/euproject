class Diyproject < ApplicationRecord
	ratyrate_rateable 'difficulty_degree'
	validates :title, :description, :age,  presence: true
	belongs_to :user
	has_many_attached :images


  default_scope {where nil}
  scope :place, -> (name) { where('place iLIKE ?', "%" + name + "%") }
  scope :age, -> (name) { where('age iLIKE ?', "%" + name + "%") }

end
