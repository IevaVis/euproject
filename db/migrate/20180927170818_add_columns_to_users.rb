class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
  	change_table :users do |t|
	  	t.integer :role
	 		t.string :name
	 		t.string :country
	 		t.string :grade_of_teaching, default: "none"
 		end
  end
end
