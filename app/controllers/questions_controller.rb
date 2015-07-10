class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    # user = User.find(session[:user_id])
    @question = Question.create(question_params)
    redirect_to question_path(@question)
  end

  def show
    @question = Question.find(params["id"])
  end

  def edit
    @question = Question.find(params[:question_id])
  end

  private

  def question_params
    params.require(:question).permit(:title, :text)
  end

end