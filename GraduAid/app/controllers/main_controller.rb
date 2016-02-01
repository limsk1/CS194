class MainController < ApplicationController
  before_filter :check_login
  layout 'blank_layout', :only => [:track]

  def check_login
    if !session[:curr_id] then
      redirect_to "/", :notice => "You should log in first."
    end
  end

  def searchClass
			
  end

  def index
    @tracks = Track.all
  end

  def track
    @user = User.find_by_id(session[:curr_id])
    if params[:track_id]==nil then
      @track = nil
    else
      @track = Track.find_by_id(params[:track_id])
    end
  end
end
