class CreateFosterParentReviews < ActiveRecord::Migration
  def change
    create_table :foster_parent_reviews do |t|
      t.integer :rating, null: false
      t.text :comment, null: false

      t.belongs_to :user, null: false
      t.belongs_to :foster_home, null: false

      t.timestamps null: false
    end
  end
end
