class RemoveColumnsFromDiyprojects < ActiveRecord::Migration[5.2]
  def change
  	change_table :diyprojects do |t|
    	remove_column :diyprojects, :objective, :string
    	remove_column :diyprojects, :duration, :string
    	remove_column :diyprojects, :materials, :string
    	remove_column :diyprojects, :results_and_tips, :string
    	remove_column :diyprojects, :links_and_resources, :string
    	remove_column :diyprojects, :tags, :text
  	end
  end
end


	 		
	 		
	 	
