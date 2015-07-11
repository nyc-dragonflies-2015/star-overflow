class SessionsController < ApplicationController
  def new
    @user = User.new
    if request.xhr?
      render(partial: 'new', object: @user)
    end
  end

  def create
    @user = User.find_by(username: session_params[:username])
    if @user.authenticate(session_params[:password])
      session[:user_id] = @user.id
      redirect_to questions_path
    else
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

    def session_params
      params.require(:user).permit(:username, :password)
    end

end