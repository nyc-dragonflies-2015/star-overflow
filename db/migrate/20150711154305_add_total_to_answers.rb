class AddTotalToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :total, :integer, :default => 0
  end
end
