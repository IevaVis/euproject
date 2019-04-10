class AddLanguageToDiyprojects < ActiveRecord::Migration[5.2]
  def change
  	change_table :diyprojects do |t|
	  	t.string :diy_language
	  end
  end
end
