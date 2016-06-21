class CreateSocialWorkerCaseComments < ActiveRecord::Migration
  def change
    create_table :social_worker_case_comments do |t|
      t.text :comment, null: false

      t.belongs_to :user, null: false
      t.belongs_to :foster_home, null: false

      t.timestamps null: false
    end
  end
end
