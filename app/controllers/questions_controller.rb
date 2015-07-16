class QuestionsController < ApplicationController

  def index
    @questions = Question.all.order(total: :desc)
  end

  def new
    # I'd love to see this in a method on ApplicationController
    # (user_is_signed_in?)
    if session[:user_id] == nil
      redirect_to login_path
    else
      @question = Question.new
    end
  end

  # classy
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

  # The call to this is:
  #
  # <%= link_to "Choose as Correct Answer", question_path(answer.question_id,
  # type: "correct", answer: answer.id), method: 'put'%>
  #
  # I think the right method is PATCH, you're updating something that's already
  # there, not a wholesale replacement (that's just some hard-core REST
  # dorkery)

  def update
    @question = Question.find(params[:id])
    if params[:type] == "correct"
      @question.correct_answer = params[:answer]
      @question.save
      redirect_to question_path(@question.id)
    else
      @question.title = params[:question][:title]
      @question.text = params[:question][:text]
      @question.save
      redirect_to questions_path
    end
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
