class AddUsersToHomes < ActiveRecord::Migration
  def change
    add_column :foster_homes, :user_id, :integer 
  end
end
