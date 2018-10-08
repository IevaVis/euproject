class Diyproject < ApplicationRecord
	validates :title, :description, :age,  presence: true
	belongs_to :user




	def self.place_search(place)
		if place
  	where('place LIKE ?',  "%#{place}%" )
  	end
  end

  def self.age_search(age)
  	if age
      where('age LIKE ?', "%#{age}%")
    end
  end

end
