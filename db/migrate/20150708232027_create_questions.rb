class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :title, null: false
      t.text :text, null: false
      t.references :user

      t.timestamps null: false
    end
  end
end
