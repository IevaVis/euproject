class AddColumnsToDiyprojects < ActiveRecord::Migration[5.2]
  def change
  	change_table :diyprojects do |t|
	  	t.string :objective
	 		t.string :duration
	 		t.string :materials
	 		t.string :results_and_tips
	 		t.string :links_and_resources
	 		t.text :tags, array: true, default: '{}'
 		end
  end
end
