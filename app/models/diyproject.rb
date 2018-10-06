class Diyproject < ApplicationRecord
	validates :title, :description, :age,  presence: true
	belongs_to :user

end
