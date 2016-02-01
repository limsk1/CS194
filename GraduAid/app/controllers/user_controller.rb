class UserController < ApplicationController
  before_filter :already_login  
  skip_before_filter :already_login, :only => [:logout]

  def already_login
    if session[:curr_id] then
      redirect_to "/main/index"
    end
  end

  def login
  end

  def post_login  
    @user = User.find_by_email(params[:email])
    if @user then
      session[:curr_id] = @user.id 
      redirect_to "/main/index"
    else
      redirect_to "/", :notice => "Wrong username or password."
    end
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
      redirect_to "/", :notice => "Registration success"
    else
      render(:action => :register)
    end
  end
end
