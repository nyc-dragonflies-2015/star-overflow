class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :text, null: false
      t.references :question
      t.references :user

      t.timestamps null: false
    end
  end
end
