class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.find_by_email(params[:sessions][:email])
    if(user && user.authenticate(params[:sessions][:password]))
    else
      flash.now[:error] = "Invalid email or password"
      render 'new'
    end
  end
  
  def destroy
    
  end
end
