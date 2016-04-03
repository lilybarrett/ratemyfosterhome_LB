class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :comment, null: false

      t.belongs_to :user, null: false
      t.belongs_to :foster_home, null: false
      t.belongs_to :type

      t.timestamps null: false
    end
  end
end
