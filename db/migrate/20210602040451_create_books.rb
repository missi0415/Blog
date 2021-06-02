class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|

      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.string :author
      t.text :body
      t.string :image_id

      t.timestamps
    end
  end
end
