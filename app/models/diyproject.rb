class Diyproject < ApplicationRecord
	validates :title, :description, :age,  presence: true
	belongs_to :user

  default_scope {where nil}
  scope :place, -> (name) { where('place iLIKE ?', "%" + name + "%") }
  scope :age, -> (name) { where('age iLIKE ?', "%" + name + "%") }

end
