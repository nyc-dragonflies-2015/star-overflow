class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    user = User.find(session[:user_id])
    @question = user.questions.create(question_params)
    redirect_to question_path(@question)
  end

  def show
    @question = Question.find(params["id"])
    @comment = Comment.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.text = params[:question][:text]
    @question.save
    redirect_to questions_path
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to questions_path
  end

  def vote
    @question = Question.find(params[:question_id])
    @question.votes.new
    @question.votes.last.user_id = session[:user_id]
    @question.votes.last.save
    if params["direction"] == "up"
      @question.total += 1
    else
      @question.total -= 1
    end
    @question.save
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :text)
  end

end