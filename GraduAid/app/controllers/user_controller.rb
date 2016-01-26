class UserController < ApplicationController
  before_filter :already_login  
  skip_before_filter :already_login, :only => [:logout]

  def already_login
    if session[:curr_id] then
      redirect_to "/main/track"
    end
  end

  def login
  end

  def logout
    reset_session
    redirect_to "/", :notice => "Log out successfully"
  end

  def register
    @user = User.new
  end

  def post_register
    @user = User.new(params[:user])    
    if @user.valid? then
      @user.save
      redirect_to "/user/login", :notice => "Registration success"
    else
      render(:action => :register)
    end
  end
end
