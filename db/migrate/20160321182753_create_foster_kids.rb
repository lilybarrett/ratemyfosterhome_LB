class CreateFosterKids < ActiveRecord::Migration
  def change
    create_table :foster_kids do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
