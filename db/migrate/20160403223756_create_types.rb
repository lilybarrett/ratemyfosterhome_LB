class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :type_name, null: false
      t.string :question, null: false 
    end
  end
end
