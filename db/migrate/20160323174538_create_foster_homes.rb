class CreateFosterHomes < ActiveRecord::Migration
  def change
    create_table :foster_homes do |t|
      t.boolean :active, null: false, default: true
      t.belongs_to :foster_kid
      t.belongs_to :foster_parent 
    end
  end
end
