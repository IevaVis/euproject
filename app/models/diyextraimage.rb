class Diyextraimage < ApplicationRecord
	belongs_to :user
	belongs_to :diyproject
	has_one_attached :image

end
