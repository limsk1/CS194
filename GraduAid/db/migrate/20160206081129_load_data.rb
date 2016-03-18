require 'csv'
class LoadData < ActiveRecord::Migration
  def up
=begin
    require 'open-uri'
    require 'rubygems'
    require 'nokogiri'

    for i in 0..1440
        doc = Nokogiri::HTML(open('http://explorecourses.stanford.edu/search?view=catalog&filter-coursestatus-Active=on&page='+i.to_s+'&catalog=&academicYear=&q=%23&collapse='))
        doc.css("div.courseInfo").each do |course|
            course_name = course.css('h2').css('span')[0].text.delete(" :").upcase
            course_info = course.css('div.courseAttributes')[0].text.delete(" \r\n\t\b").split("|")
            info_map = {}
            course_info.each do |info|
                if info.split(':').length == 1 then next end
                if info.split(':')[0] != "UGReqs" then 
                    info_map[info.split(':')[0]] = info.split(':')[1]
                else
                    info_map["UGReqs"] = info[7..-1]
                end
            end
            general_req = (info_map["UGReqs"] != nil) ? info_map["UGReqs"] : nil
            if info_map["Units"].split('-').length == 1 then
                min_unit = info_map["Units"].to_i
                max_unit = info_map["Units"].to_i
            else
                min_unit = info_map["Units"].split('-')[0].to_i
                max_unit = info_map["Units"].split('-')[1].to_i
            end
            open_aut = (info_map["Terms"] != nil) && (info_map["Terms"].include?("Aut"))
            open_win = (info_map["Terms"] != nil) && (info_map["Terms"].include?("Win"))
            open_spr = (info_map["Terms"] != nil) && (info_map["Terms"].include?("Spr"))

            Course.create(course_name: course_name, general_req: general_req, min_unit: min_unit, max_unit: max_unit, open_aut: open_aut, open_win: open_win, open_spr: open_spr)
        end
    end
=end
    CSV.foreach("course_data.csv", headers: true) do |row|
      course_hash = row.to_hash
      Course.create!(course_hash)
    end

    Course.create(course_name: "AP CALC AB Score 4", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP CALC AB Score 5", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP CALC BC Score 3", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP CALC BC Score 4,5", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP CHEM Score 5", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP PHYS B Score 4", min_unit:4, max_unit: 4, ap_credit: true)
    Course.create(course_name: "AP PHYS B Score 5", min_unit:4, max_unit: 4, ap_credit: true)
    Course.create(course_name: "AP PHYS C MECH Score 3", min_unit:4, max_unit: 4, ap_credit: true)
    Course.create(course_name: "AP PHYS C MECH Score 4,5", min_unit:5, max_unit: 5, ap_credit: true)
    Course.create(course_name: "AP PHYS C E&M Score 3", min_unit:4, max_unit: 4, ap_credit: true)
    Course.create(course_name: "AP PHYS C E&M Score 4,5", min_unit:5, max_unit: 5, ap_credit: true)
  end

  def down
    User.delete_all
    Course.delete_all
    Track.delete_all
    Taken.delete_all
    Requirement.delete_all
    Category.delete_all
    Fulfillment.delete_all
  end
end
