class MainController < ApplicationController
  before_filter :check_login
  layout 'blank_layout', :only => [:track]
  skip_before_filter :verify_authenticity_token, :only => [:potential, :update_course, :delete_course]

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
    if @my_track then
      @tracks = Track.where.not(id: @user.track.id)
    else
      @tracks = Track.all
    end
  end

  def track
    @user = User.find_by_id(session[:curr_id])
    if params[:track_id]==nil then
      if @user.track == nil then
        @track = Track.all[0]
      else
        @track = @user.track
      end
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
    user = User.find_by(id: session[:curr_id])
    response = ""
    if params[:requirement_id] != "undefined" then
      req = Requirement.find_by(id: params[:requirement_id])
      response += "Track: " + req.category.track.name + "<br>" +
                  "Category: " + req.category.show_name + "<br>"

      if req.course_id != nil then
        response += "Criteria: " + Course.find_by(id: req.course_id).course_name + "<br><br>"
      else
        response += "Criteria: " + req.criteria + "<br><br>"
      end

      req.fulfillments.each do |fulfillment|
        course = Course.find_by(id: fulfillment.course_id)
        if Taken.find_by(user_id: user.id, course_id: course.id) == nil then
          response += "\n<span>" + course.course_name + "</span><br>\n"
        end
      end
    end
    render :text => response.html_safe
  end

  def add_courses
  end

  def search_course
    course_num_list = params[:course_num].split(%r{,\s*})
    course_num_list = course_num_list.uniq
    
    if course_num_list.count == 0 then
      render :text => "No results found!"
      return
    end

    @course_list = Array.new
    course_num_list.each do |course_num|
      course = Course.find_by(course_name: params[:course_dept] + course_num.upcase)
      if course == nil then
        next
      end
      @course_list << course
    end

    if @course_list.count == 0 then
      render :text => "No results found!"
      return
    end

    render :template => "/main/show_course", :layout => false
  end

  def update_course
    user = User.find_by(id: session[:curr_id])
    params[:data].each do |course_data|
      c = Course.find_by(course_name: course_data[:course_name])
      t = Taken.find_by(user_id:user.id, course_id:c.id)
      if t == nil then
        t = Taken.new(user_id:user.id, course_id:c.id)
      end

      t[:grade] = course_data[:grade]
      t[:unit] = course_data[:unit]
      t.save!
    end

    render :text => "success"
  end

  def delete_course
    t = Taken.find_by(id: params[:taken_id])
    if t != nil then
      t.destroy!
    end

    render :text => "success"
  end
end
