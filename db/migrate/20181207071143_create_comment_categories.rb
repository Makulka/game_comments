class CreateCommentCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :comment_categories do |t|
      t.integer :comment_id
      t.integer :category_id
    end
  end
end
