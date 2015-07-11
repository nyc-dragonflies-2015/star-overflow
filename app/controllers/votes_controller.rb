class VotesController < ApplicationController

 def create
  if params["type"] == "question"
    @question = Question.find(params[:question_id])
    if user_voted?(@question) != true
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
    else
      redirect_to question_path(@question.id)
    end
  elsif params["type"] == "answer"
    @answer = Answer.find(params[:answer_id])
    if user_voted?(@answer) != true
        @answer.votes.new
        @answer.votes.last.user_id = session[:user_id]
        @answer.votes.last.save
        if params["direction"] == "up"
        @answer.total += 1
      else
        @answer.total -= 1
      end
        @answer.save
        redirect_to question_path(@answer.question_id)
    else
      redirect_to question_path(@answer.question_id)
    end

  end
 end

 def user_voted?(object_voted_on)
   votes = object_voted_on.votes
   votes.each do |x|
     if x.user_id == session[:user_id]
       return true
     end
   end
 end

end
