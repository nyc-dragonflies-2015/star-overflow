module ApplicationHelper

  def current_user
    @user = User.find(session[:user_id])
  end

  def user_answers
    @answers = User.find(session[:user_id]).answers
  end

  def answered_questions
    @questions_array = []
    User.find(session[:user_id]).answers.each do |answer|
      @questions_array << answer.question
    end
    @questions_array
  end

end
