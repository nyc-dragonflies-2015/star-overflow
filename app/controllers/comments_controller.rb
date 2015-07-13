class CommentsController < ApplicationController
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
      params[:answer_id] ? question_id = Answer.find(params[:answer_id]).question_id : question_id = params[:question_id]

      question_id = params[:question_id]
      redirect_to question_path(question_id)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
