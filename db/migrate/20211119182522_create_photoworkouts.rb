class CreatePhotoworkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :photoworkouts do |t|
      t.text :caption
      t.integer :challenge_id
      t.integer :user_id
      t.integer :likes_count
      t.string :photo_locator
      t.integer :calories
      t.string :main_exercise

      t.timestamps
    end
  end
end
