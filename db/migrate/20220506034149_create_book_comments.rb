class CreateBookComments < ActiveRecord::Migration[6.1]
  def change
    create_table :book_comments do |t|
      t.references :book
      t.references :user
      t.text :comment

      t.timestamps
    end
  end
end
