class CommentsController < ApplicationController
  def create
    @question = Question.find(params[:question_id])
    @comment = @question.comments.new(text:     comment_params[:text],
                                      user_id:  session[:user_id])
    if @comment.save
      redirect_to @question
    else
      redirect_to root_path
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @question
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end

end
