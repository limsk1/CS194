class ShowInfo
  attr_accessor :requirement, :fulfilled, :taken, :course_name
  
  def initialize(requirement, fulfilled, taken, course_name)
    @requirement = requirement
    @fulfilled = fulfilled
    @taken = taken
    @course_name = course_name
  end
end

class MainController < ApplicationController
  before_filter :check_login
  layout 'blank_layout', :only => [:track]
  skip_before_filter :verify_authenticity_token, :only => [:potential]

  def check_login
    if !session[:curr_id] then
      redirect_to "/", :notice => "You should log in first."
    end
  end

  def searchClass
			
  end

  def index
    @user = User.find_by_id(session[:curr_id])
    @my_track = @user.track
    @tracks = Track.where.not(id: @user.track.id)
  end

  def track
    @user = User.find_by_id(session[:curr_id])
    if params[:track_id]==nil then
      @track = @user.track
    else
      @track = Track.find_by_id(params[:track_id])
    end

    requirements = Requirement.where(track_id: @track.id)
    takens = Taken.where(user_id: @user.id)

    @infos = Array.new

    requirements.each do |requirement|
      taken = Taken.find_by(user_id: @user.id, course_id: requirement.course_id)
      course_name = Course.find_by(id: requirement.course_id).course_name
      if taken==nil then
        info = ShowInfo.new(requirement, false, nil, course_name)
      else
        info = ShowInfo.new(requirement, true, taken, course_name)
      end
      @infos << info
    end
  end

  def potential
    response = "<div>"
    if params[:criteria] && params[:track_id] then
      response += "<b>Track:" + Track.find_by_id(params[:track_id]).name + "<br>Criteria:" + params[:criteria] + "</b><br><br>"
      requirements = Requirement.where(criteria: params[:criteria], track_id: params[:track_id])

      requirements.each do |requirement|
        course_name = Course.find_by(id: requirement.course_id).course_name
        response += "\n<span>" + course_name + "</span><br>\n"
      end
    end

    response += "</div>"
    render :text => response.html_safe
  end
end
