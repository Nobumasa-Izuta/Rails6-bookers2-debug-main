class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.references :book
      t.references :user

      t.timestamps
    end
  end
end
