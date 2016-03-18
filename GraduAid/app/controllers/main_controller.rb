require 'uri'
require 'nokogiri'
require 'open-uri'
require 'set'

class MainController < ApplicationController
  before_filter :check_login
  layout 'blank_layout', :only => [:track]
  skip_before_filter :verify_authenticity_token, :only => [:potential, :update_course, :delete_course, :update_ap]

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
    @gen_req = Track.find_by(name: 'General Requirement')
    url = "http://explorecourses.stanford.edu/?view=xml-20140630&academicYear=20152016"
    doc = Nokogiri::HTML(open(url))
    dept_set = doc.xpath("//department")
    @dept_list = []
    dept_set.each do |dept|
        @dept_list << dept['name']
    end
    @dept_list.sort!
  
  end

  def track
    @user = User.find_by_id(session[:curr_id])
    if params[:track_id]==nil then
      if @user.track == nil then
        @track = Track.find_by(name: 'General Requirement')
      else
        @track = @user.track
      end
    else
      @track = Track.find_by_id(params[:track_id])
    end

    @infos = Hash.new
    @category_unit = Hash.new
    used = Hash.new

    total_req = 0
    satis_req = 0

    grade = ["A+", "A", "A-", "B+", "B", "B-", "C+", "C", "C-", "D+", "D", "D-", "F"]
    manual_grade_order = "case"
    for i in 0..grade.length - 1
        manual_grade_order += " when grade = '" + grade[i] + "' then " + i.to_s
    end
    manual_grade_order += " end ASC"

    temp_str = "(select count(*) from fulfillments where (select track_id from categories where id = (select category_id from requirements where id = fulfillments.requirement_id)) = '" + @track.id.to_s + "' and course_id = takens.course_id) ASC "

    @track.categories.each do |category|
        requirements = category.requirements.sort_by {|r| r.priority}.reverse
        total_unit = 0
        requirements.each do |requirement|
            if requirement.course_id != nil then
                total_req += 1
                taken = Taken.find_by(user_id: @user.id, course_id: requirement.course_id)
                @infos[requirement.id] = taken
                if taken != nil then
                    satis_req += 1 
                    used[taken.id] = 1
                    total_unit += taken.unit
                end
            else
                fulfillments_id = Array.new
                requirement.fulfillments.each do |f|
                    fulfillments_id << f.course_id
                end
                total_req += requirement.num_courses

                temp_arr = Taken.where('user_id = (:id) and course_id in (:fullfillments)', :id => @user.id, :fullfillments => fulfillments_id)
                                    .order(temp_str).order(manual_grade_order)
                temp_arr_2 = Array.new

                temp_arr.each do |t|
                    c = Course.find_by(id: t.course_id)
                    if used[t.id] == nil or c.ap_credit then
                        temp_arr_2 << t
                    end
                end

                while temp_arr_2.length < requirement.num_courses do
                    temp_arr_2 << nil
                end

                @infos[requirement.id] = temp_arr_2.take(requirement.num_courses)

                @infos[requirement.id].each do |t|
                    if t != nil then
                        c = Course.find_by(id: t.course_id)
                        satis_req += 1
                        total_unit += t.unit
                        if c.ap_credit then next end
                        used[t.id] = 1
                    end
                end
            end
        end
        @category_unit[category.id] = total_unit
        progress_f = (satis_req.to_f / total_req) * 100
        @progress = progress_f.to_i
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

      quarter_list = ["Aut", "Win", "Spr"]

      fulfillments_id = Array.new
      req.fulfillments.each do |f|
        fulfillments_id << f.course_id
      end

      quarter_list.each do |quarter|
        case quarter
        when "Aut"
          response += "\n<span class='sidebar-title' style='text-align: center; margin: auto;'><b>" + 'AUTUMN' + "</b></span><br>"
          courses = Course.where('id in (:id) and open_aut = (:true) and ap_credit = (:false)', :id => fulfillments_id, :true => true, :false =>false)
                            .order('((select count(*) from "fulfillments" where fulfillments.course_id == courses.id)
                                    + (select count(*) from "takens" where takens.course_id == courses.id)
                                    + courses.views
                                    + 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "t")
                                    - 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "f")) DESC ').take(10)
        when "Win"
          response += "\n<span class='sidebar-title'><b>" + 'WINTER' + "</b></span><br>"
          courses = Course.where('id in (:id) and open_win = (:true) and ap_credit = (:false)', :id => fulfillments_id, :true => true, :false =>false)
                            .order('((select count(*) from "fulfillments" where fulfillments.course_id == courses.id)
                                    + (select count(*) from "takens" where takens.course_id == courses.id)
                                    + courses.views
                                    + 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "t")
                                    - 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "f")) DESC').take(10)
        when "Spr"
          response += "\n<span class='sidebar-title'><b>" + 'SPRING' + "</b></span><br>"
          courses = Course.where('id in (:id) and open_spr = (:true) and ap_credit = (:false)', :id => fulfillments_id, :true => true, :false =>false)
                            .order('((select count(*) from "fulfillments" where fulfillments.course_id == courses.id)
                                    + (select count(*) from "takens" where takens.course_id == courses.id)
                                    + courses.views
                                    + 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "t")
                                    - 2 * (select count(*) from "likes" where likes.course_id == courses.id and likes.up == "f")) DESC').take(10)
        end

        recommend_done = false
        courses.each do |course|
          if Taken.find_by(user_id: user.id, course_id: course.id) == nil then
            if not recommend_done then
                response += "\n<a href = '/main/course_data/" + course.id.to_s + "' style='text-decoration: none; color: inherit;'><span>" + course.course_name + " ★" + "</span></a><br>\n"
                recommend_done = true
            else
                response += "\n<a href = '/main/course_data/" + course.id.to_s + "' style='text-decoration: none; color: inherit;'><span>" + course.course_name + "</span></a><br>\n"
            end
          end
        end
        response += "<br>";
      end
    end
    render  :text => response.html_safe
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
      course = Course.find_by(course_name: params[:course_dept] + course_num.upcase, ap_credit: false)
      if course == nil then
        next
      end
      @course_list << course
    end

    if @course_list.count == 0 then
      render :text => "No results found!"
      return
    end

    @return_url = params[:return_url]
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

  def update_ap
    user = User.find_by(id: session[:curr_id])
    params[:data].each do |ap_data|
      a = ApCredit.find_by(name: ap_data[:name].gsub(/&amp;/, '&'), user_id: user.id)
      prev_grade = a.grade
      a.grade = ap_data[:grade]
      a.taken = ap_data[:taken]
      a.save!

      prev_c = Course.where('course_name LIKE \'%' + ap_data[:name].upcase + '%\' and course_name LIKE \'%' + prev_grade.to_s + '%\'' )
      if prev_c.length > 0 then
        prev_t = Taken.find_by(user_id: user.id, course_id: prev_c[0].id)
        if prev_t then
          prev_t.destroy!
        end
      end

      curr_c = Course.where('course_name LIKE \'%' + ap_data[:name].upcase + '%\' and course_name LIKE \'%' + a.grade.to_s + '%\'' )
      if curr_c.length > 0 then
        curr_t = Taken.new()
        curr_t.user = user
        curr_t.course = curr_c[0]
        curr_t.unit = curr_c[0].max_unit
        curr_t.grade = "N/A"
        curr_t.save!
      end
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

  def explore_courses
    url = "http://explorecourses.stanford.edu/search?view=xml-20140630&filter-coursestatus-Active=on&page=0&catalog=&q=" + URI.escape(params[:query]) + "&academicYear=20152016"
    doc = Nokogiri::HTML(open(url))
    @course_list = doc.xpath("//course")
  end

  def course_data
    @course = Course.find_by_id(params[:id])
    user = User.find_by_id(session[:curr_id])
    @taken = Taken.find_by(user_id:user.id, course_id: @course.id)
    @course.views += 1
    @course.save!
    url = "http://explorecourses.stanford.edu/search?view=xml-20140630&filter-coursestatus-Active=on&page=0&catalog=&q=" + URI.escape(@course.course_name) + "&academicYear=20152016"
    doc = Nokogiri::HTML(open(url))

    doc.xpath("//course").each do |xml_obj|
        if @course.course_name == xml_obj.css('subject')[0].text + xml_obj.css('code')[0].text then
            @course_xml_obj = xml_obj
            break
        end
    end

    @course_title = @course_xml_obj.xpath("//course/subject")[0].text + " " + @course_xml_obj.xpath("//course/code")[0].text
    
    @course_subtitle = @course_xml_obj.xpath("//course/title")[0].text
    
    instructor_set = Set.new
    instructor_array = Array.new
    @course_xml_obj.xpath("//instructor").each do |inst|
      inst_alias = inst.xpath(".//name")[0].text + "(" + inst.xpath(".//role")[0].text + ")"
      if not instructor_set.include?(inst_alias) then
        instructor_set.add(inst_alias)
        instructor_array << inst_alias
      end
    end
    @course_instructor = instructor_array.join(', ')

    if not (@course.open_aut or @course.open_win or @course.open_spr) then
      @course_quarters = "Not given this year"
    else
      course_open_at = Array.new
      if @course.open_aut then
        course_open_at << "Aut"
      end

      if @course.open_win then
        course_open_at << "Win"
      end

      if @course.open_spr then
        course_open_at << "Spr"
      end

      @course_quarters = course_open_at.join(', ')
    end

    if @course.min_unit == @course.max_unit then
      @course_units = @course.max_unit.to_s
    else
      @course_units = @course.min_unit.to_s + "-" + @course.max_unit.to_s
    end

    @course_grading = @course_xml_obj.xpath("//course/grading")[0].text

    @course_description = @course_xml_obj.xpath("//course/description")[0].text


    @like = Like.find_by(user_id:session[:curr_id], course_id:params[:id])

    @like_count = Like.where(course_id:params[:id], up:true).count
    @dislike_count = Like.where(course_id:params[:id], up:false).count
  end
end
