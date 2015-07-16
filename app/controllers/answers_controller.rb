class AnswersController < ApplicationController
  def index
    @answers = Answer.all
  end

  def new
    @answer = Answer.new
    @user_id = 1 # Hmmmmm...... why are we hard coding this?
    @question_id = 2 # Ditto this.  I think you've got something broken that you're covering up...
  end

  def create
    # If you redirect to the same place both for the if and else...why have the if/else?
    # answer = Answer.new(answer_params)
    # redirect_to question_path(answer.question_id)
    #
    # Is logically identical

    answer = Answer.new(answer_params)
    if answer.save
      redirect_to question_path(answer.question_id)
    else
      redirect_to question_path(answer.question_id)
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
    # ALSO
    # redirect_to question_path(answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:text, :user_id, :question_id)
  end
end
