class QuestionsController < ApplicationController

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    user = User.find(session[:user_id])
    @question = user.questions.create()
  end

end