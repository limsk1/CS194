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

    @infos = Hash.new
    @category_unit = Hash.new
    used = Hash.new

    @track.categories.each do |category|
        requirements = category.requirements.sort_by {|r| r.priority}.reverse
        total_unit = 0
        requirements.each do |requirement|
            if requirement.course_id != nil then
                taken = Taken.find_by(user_id: @user.id, course_id: requirement.course_id)
                @infos[requirement.id] = taken
                if taken != nil then 
                    used[taken.id] = 1
                    total_unit += taken.unit
                end
            else
                temp_arr = Array.new
                requirement.fulfillments.each do |fulfillment|
                    taken = Taken.find_by(user_id: @user.id, course_id: fulfillment.course.id)
                    if taken != nil and used[taken.id] == nil then
                        temp_arr << taken
                    end
                end
                
                while temp_arr.length < requirement.num_courses do
                    temp_arr << nil
                end

                @infos[requirement.id] = temp_arr.take(requirement.num_courses)

                @infos[requirement.id].each do |t|
                    if t != nil then
                        total_unit += t.unit
                        used[t.id] = 1
                    end
                end
            end
        end
        @category_unit[category.id] = total_unit
    end
  end

  def potential
    response = "<div>"
=begin
    if params[:criteria] && params[:track_id] then
      response += "<b>Track:" + Track.find_by_id(params[:track_id]).name + "<br>Criteria:" + params[:criteria] + "</b><br><br>"
      requirements = Requirement.where(criteria: params[:criteria], track_id: params[:track_id])

      requirements.each do |requirement|
        course_name = Course.find_by(id: requirement.course_id).course_name
        response += "\n<span>" + course_name + "</span><br>\n"
      end
    end
=end
    response += "</div>"
    render :text => response.html_safe
  end
end
