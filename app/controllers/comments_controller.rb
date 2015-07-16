# This controller is too hairy.....
class CommentsController < ApplicationController
  # OK, this method is clearly gross.  The question is how are we going to fix
  # it?
  #
  def create
    if request.xhr?
      if params[:answer_id]
        answer = Answer.find(params[:answer_id])
        comment = answer.comments.new(text: comment_params[:text], user_id: session[:user_id])
        comment.save

        render partial: '/comments/show', locals: {comment: comment, target: answer}
      else
        question = Question.find(params[:question_id])
        comment = question.comments.new(text: comment_params[:text], user_id: session[:user_id])
        comment.save

        render partial: '/comments/show', locals: {comment: comment, target: question}
      end
    else
      if params[:answer_id]
        @answer = Answer.find(params[:answer_id])
        @question = Question.find(@answer.question_id)
        @comment = @answer.comments.new(text: comment_params[:text], user_id: session[:user_id])
      else
        @question = Question.find(params[:question_id])
        @comment = @question.comments.new(text: comment_params[:text], user_id: session[:user_id])
      end
      if @comment.save
        redirect_to @question
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    Comment.find(params[:id]).destroy

    if request.xhr?
      # "render :nothing" didn't work, so I had to render an empty partial.
      render partial: '/comments/nothing'
    else
      # This is not the correct use of a ternary
      #
      # A ternary is an assignment where the right side of the `=` is the
      # ternary decision.
      # question_id = params[:answer_id] ? Answer.find(params[:answer_id]).question_id : params[:question_id]
      params[:answer_id] ? question_id = Answer.find(params[:answer_id]).question_id : question_id = params[:question_id]

      question_id = params[:question_id]
      # This logic ^^ seems weird.  Didn't we do logic around question_id and
      # then now we're hard assigning here.  Seems suspicious.  I'm pretty sure
      # there's a bug lurking in here....
      #
      redirect_to question_path(question_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
