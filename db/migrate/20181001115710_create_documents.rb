class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
    	t.belongs_to :user, index: true
    	t.string :title
    	t.text :tags, array: true
    	t.string :doc_language
    	t.boolean :is_public
      t.boolean :terms
      t.timestamps
    end
  end
end
