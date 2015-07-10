class AddTotalToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :total, :integer, :default => 0
  end
end
