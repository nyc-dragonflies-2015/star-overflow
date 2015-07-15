module ApplicationHelper

  def current_user
    @user = User.find(session[:user_id])
  end

  # This name isn't as descriptive as it ought be
  #
  # def current_user_answers
  #   current_user.answers
  # end

  def user_answers
    @answers = User.find(session[:user_id]).answers
  end

  # Lowell, there's a better Enumerable here.  Transform an Array to an Array.
  # It's one of the _big_ Enumerables
  def answered_questions
    @questions_array = []
    # Lowell, you gave yourself a method that would make this more terse, but
    # you're not using it (it's up about 8 lines).  Why not.
    #
    # user_answers.map(&:question)
    User.find(session[:user_id]).answers.each do |answer|
      @questions_array << answer.question
    end
    @questions_array
  end

end
