class VotesController < ApplicationController

 def create
   @question = Question.find(params[:question_id])
   if user_voted?(@question) != true
     if params["type"] == "question"
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
   else
   redirect_to question_path(@question.id)
   end
 end

 def user_voted?(question)
   votes = question.votes
   votes.each do |x|
     if x.user_id == session[:user_id]
       return true
     end
   end
 end

end
