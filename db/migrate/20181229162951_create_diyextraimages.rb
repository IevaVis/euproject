class CreateDiyextraimages < ActiveRecord::Migration[5.2]
  def change
  	create_table :diyextraimages do |t|
  		t.belongs_to :user, index: true
  		t.belongs_to :diyproject, index: true
		end
	end	
end
