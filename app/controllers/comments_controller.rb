class CommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.new(comment_params)
    if @comment.save
      redirect_to @question
    else
      redirect_to root_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
