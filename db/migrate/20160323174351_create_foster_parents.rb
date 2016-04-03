class CreateFosterParents < ActiveRecord::Migration
  def change
    create_table :foster_parents do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
    end
  end
end
