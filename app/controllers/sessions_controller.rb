class SessionsController < ApplicationController
  
  def new
    @title = "Sign In"
  end
  
  def create
    user = User.authenticate(params[:sessions][:email], params[:sessions][:password])
    
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      render 'new'  
    else
      sign_in user
      redirect_to user_path(user)
    end
  end
  
  def destroy
    
  end
  
end
