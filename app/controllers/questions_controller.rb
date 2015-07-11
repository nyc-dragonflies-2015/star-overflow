class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(total: :desc)
  end

  def new
    if Question.known_user?(session[:user_id]) == false
      redirect_to login_path
    else
      @question = Question.new
    end
  end

  def create
    user = User.find(session[:user_id])
    @question = user.questions.create(question_params)
    redirect_to question_path(@question)
  end

  def show
    @question = Question.find(params["id"])
    @answer = Answer.new
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

  private

  def question_params
    params.require(:question).permit(:title, :text)
  end

end