class VotesController < ApplicationController

  # This method is bananas.
  #
  # 1.  Really long
  # 2.  Logic is complex

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

 # Couldn't this be on User as User#voted_on?(object) ?
 def user_voted?(object_voted_on)
  if object_voted_on.user_id == session[:user_id]
    return true
  end
  votes = object_voted_on.votes

  # Lowell, there's definitely a better Enumerable to use here.
  votes.each do |x|
     if x.user_id == session[:user_id]
       return true
     end
   end
 end

end
