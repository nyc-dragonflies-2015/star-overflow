class AddCorrectAnswerToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :correct_answer, :integer, :default => nil
  end
end
