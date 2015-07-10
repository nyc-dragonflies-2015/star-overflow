class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end
  
  def new
    @answer = Answer.new
    @user_id = 1
    @question_id = 2
  end

  def create
    answer = Answer.new(answer_params)

    if answer.save
      redirect_to question_path(answer.question_id)
    else
      redirect_to new_question
    end
  end

  def edit
    @answer = Answer.find(params[:id])
  end

  def update
    answer = Answer.find(params[:id])
    answer.update_attributes(answer_params)

    redirect_to question_path(answer.question_id)
  end

  def destroy
    answer = Answer.find(params[:id]).destroy

    redirect_to question_path(answer.question_id)
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id)
  end
end
