class CreateDiyprojects < ActiveRecord::Migration[5.2]
  def change
    create_table :diyprojects do |t|
    	t.belongs_to :user
	  	t.string :title
	 		t.string :description
    	t.boolean :is_indoors
    	t.string :age
    end
  end
end
