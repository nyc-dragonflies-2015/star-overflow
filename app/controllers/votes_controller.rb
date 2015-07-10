class VotesController < ApplicationController

  def create
    if params["type"] == "question"
      @question = Question.find(params[:question_id])
      @question.votes.new
      @question.votes.last.user_id = session[:user_id]
      @question.votes.last.save
      if params["direction"] == "up"
        @question.total += 1
      else
        @question.total -= 1
      end
      @question.save
      redirect_to question_path(@question.id)
    end
  end

end
