class LoadGenReq < ActiveRecord::Migration
  def up
    gen_req = Track.new(name: 'General Requirement')
    gen_req.save!

    think = Category.new(show_name: 'THINK', min_courses: 1)
    think.track = gen_req
    think.save!

    think_req = Requirement.new(num_courses: 1, criteria: 'THINK', priority: 4, repeatable: false)
    think_req.category = think
    think_req.save!

    courses = Course.where('general_req LIKE \'%THINK%\'')
    courses.each do |course|
        think_ful = Fulfillment.new
        think_ful.requirement = think_req
        think_ful.course = course
        think_ful.save!
    end

    way_a_ii = Category.new(show_name: 'WAY-A-II', min_courses: 1)
    way_a_ii.track = gen_req
    way_a_ii.save!

    way_a_ii_req = Requirement.new(num_courses: 1, criteria: 'WAY-A-II', priority: 4, repeatable: false)
    way_a_ii_req.category = way_a_ii
    way_a_ii_req.save!

    courses = Course.where('general_req LIKE \'%WAY-A-II%\'')
    courses.each do |course|
        way_a_ii_ful = Fulfillment.new
        way_a_ii_ful.requirement = way_a_ii_req
        way_a_ii_ful.course = course
        way_a_ii_ful.save!
    end

    way_aqr = Category.new(show_name: 'WAY-AQR', min_courses: 1)
    way_aqr.track = gen_req
    way_aqr.save!

    way_aqr_req = Requirement.new(num_courses: 1, criteria: 'WAY-AQR', priority: 4, repeatable: false)
    way_aqr_req.category = way_aqr
    way_aqr_req.save!

    courses = Course.where('general_req LIKE \'%WAY-AQR%\'')
    courses.each do |course|
        way_aqr_ful = Fulfillment.new
        way_aqr_ful.requirement = way_aqr_req
        way_aqr_ful.course = course
        way_aqr_ful.save!
    end

    way_ce = Category.new(show_name: 'WAY-CE', min_courses: 1)
    way_ce.track = gen_req
    way_ce.save!

    way_ce_req = Requirement.new(num_courses: 1, criteria: 'WAY-CE', priority: 4, repeatable: false)
    way_ce_req.category = way_ce
    way_ce_req.save!

    courses = Course.where('general_req LIKE \'%WAY-CE%\'')
    courses.each do |course|
        way_ce_ful = Fulfillment.new
        way_ce_ful.requirement = way_ce_req
        way_ce_ful.course = course
        way_ce_ful.save!
    end

    way_ed = Category.new(show_name: 'WAY-ED', min_courses: 1)
    way_ed.track = gen_req
    way_ed.save!

    way_ed_req = Requirement.new(num_courses: 1, criteria: 'WAY-ED', priority: 4, repeatable: false)
    way_ed_req.category = way_ed
    way_ed_req.save!

    courses = Course.where('general_req LIKE \'%WAY-ED%\'')
    courses.each do |course|
        way_ed_ful = Fulfillment.new
        way_ed_ful.requirement = way_ed_req
        way_ed_ful.course = course
        way_ed_ful.save!
    end

    way_er = Category.new(show_name: 'WAY-ER', min_courses: 1)
    way_er.track = gen_req
    way_er.save!

    way_er_req = Requirement.new(num_courses: 1, criteria: 'WAY-ER', priority: 4, repeatable: false)
    way_er_req.category = way_er
    way_er_req.save!

    courses = Course.where('general_req LIKE \'%WAY-ER%\'')
    courses.each do |course|
        way_er_ful = Fulfillment.new
        way_er_ful.requirement = way_er_req
        way_er_ful.course = course
        way_er_ful.save!
    end

    way_fr = Category.new(show_name: 'WAY-FR', min_courses: 1)
    way_fr.track = gen_req
    way_fr.save!

    way_fr_req = Requirement.new(num_courses: 1, criteria: 'WAY-FR', priority: 4, repeatable: false)
    way_fr_req.category = way_fr
    way_fr_req.save!

    courses = Course.where('general_req LIKE \'%WAY-FR%\'')
    courses.each do |course|
        way_fr_ful = Fulfillment.new
        way_fr_ful.requirement = way_fr_req
        way_fr_ful.course = course
        way_fr_ful.save!
    end

    way_si = Category.new(show_name: 'WAY-SI', min_courses: 1)
    way_si.track = gen_req
    way_si.save!

    way_si_req = Requirement.new(num_courses: 1, criteria: 'WAY-SI', priority: 4, repeatable: false)
    way_si_req.category = way_si
    way_si_req.save!

    courses = Course.where('general_req LIKE \'%WAY-SI%\'')
    courses.each do |course|
        way_si_ful = Fulfillment.new
        way_si_ful.requirement = way_si_req
        way_si_ful.course = course
        way_si_ful.save!
    end

    way_sma = Category.new(show_name: 'WAY-SMA', min_courses: 1)
    way_sma.track = gen_req
    way_sma.save!

    way_sma_req = Requirement.new(num_courses: 1, criteria: 'WAY-SMA', priority: 4, repeatable: false)
    way_sma_req.category = way_sma
    way_sma_req.save!

    courses = Course.where('general_req LIKE \'%WAY-SMA%\'')
    courses.each do |course|
        way_sma_ful = Fulfillment.new
        way_sma_ful.requirement = way_sma_req
        way_sma_ful.course = course
        way_sma_ful.save!
    end

    pwr1 = Category.new(show_name: 'Writing 1', min_courses: 1)
    pwr1.track = gen_req
    pwr1.save!

    pwr1_req = Requirement.new(num_courses: 1, criteria: 'Writing 1', priority: 4, repeatable: false)
    pwr1_req.category = pwr1
    pwr1_req.save!

    courses = Course.where('general_req LIKE \'%Writing 1%\'')
    courses.each do |course|
        pwr_1_ful = Fulfillment.new
        pwr_1_ful.requirement = pwr1_req
        pwr_1_ful.course = course
        pwr_1_ful.save!
    end

    pwr2 = Category.new(show_name: 'Writing 2', min_courses: 1)
    pwr2.track = gen_req
    pwr2.save!

    pwr2_req = Requirement.new(num_courses: 1, criteria: 'Writing 2', priority: 4, repeatable: false)
    pwr2_req.category = pwr2
    pwr2_req.save!

    courses = Course.where('general_req LIKE \'%Writing 2%\'')
    courses.each do |course|
        pwr_2_ful = Fulfillment.new
        pwr_2_ful.requirement = pwr2_req
        pwr_2_ful.course = course
        pwr_2_ful.save!
    end    
  end

  def down
  end
end
