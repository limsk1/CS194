class LoadCsHci < ActiveRecord::Migration
  def up
    hci = Track.new(name: 'CS-HCI')
    hci.save!

    math = Category.new(show_name: 'Math', min_units: 26, min_courses: 6)
    math.track = hci
    math.save!

    math_41 = Requirement.new(course_id: Course.find_by(course_name: 'MATH41').id, num_courses: 1, priority: 4, repeatable: false)
    math_41.category = math
    math_41.save!

    math_41_ful = Fulfillment.new
    math_41_ful.requirement = math_41
    math_41_ful.course = Course.find_by(course_name: 'MATH41')
    math_41_ful.save!

    math_42 = Requirement.new(course_id: Course.find_by(course_name: 'MATH42').id, num_courses: 1, priority: 4, repeatable: false)
    math_42.category = math
    math_42.save!

    math_42_ful = Fulfillment.new
    math_42_ful.requirement = math_42
    math_42_ful.course = Course.find_by(course_name: 'MATH42')
    math_42_ful.save!

    cs_103 = Requirement.new(course_id: Course.find_by(course_name: 'CS103').id, num_courses: 1, priority: 4, repeatable: false)
    cs_103.category = math
    cs_103.save!

    cs_103_ful = Fulfillment.new
    cs_103_ful.requirement = cs_103
    cs_103_ful.course = Course.find_by(course_name: 'CS103')
    cs_103_ful.save!

    cs_109 = Requirement.new(course_id: Course.find_by(course_name: 'CS109').id, num_courses: 1, priority: 4, repeatable: false)
    cs_109.category = math
    cs_109.save!

    cs_109_ful = Fulfillment.new
    cs_109_ful.requirement = cs_109
    cs_109_ful.course = Course.find_by(course_name: 'CS109')
    cs_109_ful.save!

    math_elec = Requirement.new(num_courses: 2, criteria: 'Math Elective', priority: 1, repeatable: false)
    math_elec.category = math
    math_elec.save!

    math_elec_list = ['MATH51', 'MATH104', 'MATH108', 'MATH109', 'MATH110', 'MATH113', 'CS157', 'CS205A', 'PHIL151', 'CME100', 'CME102', 'CME104']
    math_elec_list.each do |elec|
        math_elec_ful = Fulfillment.new
        math_elec_ful.requirement = math_elec
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        math_elec_ful.course = Course.find_by(course_name: elec)
        math_elec_ful.save!    
    end

    sci = Category.new(show_name: 'Science', min_units: 11, min_courses: 3)
    sci.track = hci
    sci.save!

    mech = Requirement.new(num_courses: 1, criteria: 'Mechanics', priority: 4, repeatable: false)
    mech.category = sci
    mech.save!

    mech_list = ['PHYSICS21', 'PHYSICS41', 'PHYSICS61']
    mech_list.each do |elec|
        mech_ful = Fulfillment.new
        mech_ful.requirement = mech
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        mech_ful.course = Course.find_by(course_name: elec)
        mech_ful.save!    
    end

    em = Requirement.new(num_courses: 1, criteria: 'Electricity and Magnetism', priority: 4, repeatable: false)
    em.category = sci
    em.save!

    em_list = ['PHYSICS23', 'PHYSICS43', 'PHYSICS63']
    em_list.each do |elec|
        em_ful = Fulfillment.new
        em_ful.requirement = em
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        em_ful.course = Course.find_by(course_name: elec)
        em_ful.save!    
    end

    sci_elec = Requirement.new(num_courses: 1, criteria: 'Science Elective', priority: 1, repeatable: false)
    sci_elec.category = sci
    sci_elec.save!

    sci_elec_list = ['BIO41', 'BIO42', 'BIO43', 'BIO44X', 'BIO44Y', 'CEE63', 'CEE64', 'CEE70', 'CHEM31A', 'CHEM31B', 'CHEM31X', 'CHEM33', 'CHEM35']
    sci_elec_list += ['CHEM131', 'CHEM135', 'EARTHSYS10', 'EARTHSYS30', 'ENGR31', 'GS1A', 'PHYSICS25', 'PHYSICS45', 'PHYSICS65', 'PHYSICS42']
    sci_elec_list += ['PHYSICS44', 'PHYSICS46', 'PHYSICS62', 'PHYSICS64', 'PHYSICS67', 'PSYCH30', 'PSYCH55', 'PHYSICS21', 'PHYSICS41', 'PHYSICS61']
    sci_elec_list += ['PHYSICS23', 'PHYSICS43', 'PHYSICS63']
                   
    sci_elec_list.each do |elec|
        sci_elec_ful = Fulfillment.new
        sci_elec_ful.requirement = sci_elec
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        sci_elec_ful.course = Course.find_by(course_name: elec)
        sci_elec_ful.save!    
    end

    tis = Category.new(show_name: 'Technology in Society', min_courses: 1)
    tis.track = hci
    tis.save!

    tis_elec = Requirement.new(num_courses: 1, criteria: 'Technology in Society', priority: 1, repeatable: false)
    tis_elec.category = tis
    tis_elec.save!

    tis_elec_list = ['BIOE131', 'CLASSICS151', 'COMM120W', 'COMM169', 'ECON116', 'ENGR129', 'ENGR131', 'ENGR145', 'HISTORY205A']
    tis_elec_list += ['HUMBIO174', 'MS&E181', 'MS&E193', 'MS&E197', 'POLISCI114S', 'PUBLPOL194', 'STS1', 'CS181', 'CS181W']

    tis_elec_list.each do |elec|
        tis_elec_ful = Fulfillment.new
        tis_elec_ful.requirement = tis_elec
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        tis_elec_ful.course = Course.find_by(course_name: elec)
        tis_elec_ful.save!    
    end    

    engr = Category.new(show_name: 'Engineering Fundamentals', min_units: 13, min_courses: 3)
    engr.track = hci
    engr.save!   

    prog_abs = Requirement.new(num_courses: 1, criteria: 'Programming Abstractions', priority: 4, repeatable: false)
    prog_abs.category = engr
    prog_abs.save!

    prog_abs_list = ['CS106B', 'CS106X']

    prog_abs_list.each do |elec|
        prog_abs_ful = Fulfillment.new
        prog_abs_ful.requirement = prog_abs
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        prog_abs_ful.course = Course.find_by(course_name: elec)
        prog_abs_ful.save!    
    end    

    electronics = Requirement.new(num_courses: 1, criteria: 'Introductory Electronics', priority: 4, repeatable: false)
    electronics.category = engr
    electronics.save!

    electronics_list = ['ENGR40', 'ENGR40A', 'ENGR40M']

    electronics_list.each do |elec|
        electronics_ful = Fulfillment.new
        electronics_ful.requirement = electronics
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end        
        electronics_ful.course = Course.find_by(course_name: elec)
        electronics_ful.save!    
    end    

    engr_elec = Requirement.new(num_courses: 1, criteria: 'Engineering Electives', priority: 1, repeatable: false)
    engr_elec.category = engr
    engr_elec.save!

    engr_elec_list = ['ENGR10', 'ENGR14', 'ENGR15', 'ENGR20', 'ENGR25B', 'ENGR25E', 'ENGR30', 'ENGR40', 'ENGR40A']
    engr_elec_list += ['ENGR40M', 'ENGR40P', 'ENGR50', 'ENGR50E', 'ENGR50M', 'ENGR60', 'ENGR62', 'ENGR80', 'ENGR90']

    engr_elec_list.each do |elec|
        engr_elec_ful = Fulfillment.new
        engr_elec_ful.requirement = engr_elec
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        engr_elec_ful.course = Course.find_by(course_name: elec)
        engr_elec_ful.save!    
    end   

    core = Category.new(show_name: 'Core', min_units: 15, min_courses: 3)
    core.track = hci
    core.save!

    cs_107 = Requirement.new(num_courses: 1, criteria: 'Computer Organization and Systems', priority: 4, repeatable: false)
    cs_107.category = core
    cs_107.save!

    cs_107_list = ['CS107', 'CS107E']

    cs_107_list.each do |elec|
        cs_107_ful = Fulfillment.new
        cs_107_ful.requirement = cs_107
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        cs_107_ful.course = Course.find_by(course_name: elec)
        cs_107_ful.save!    
    end    

    cs_110 = Requirement.new(course_id: Course.find_by(course_name: 'CS110').id, num_courses: 1, priority: 4, repeatable: false)
    cs_110.category = core
    cs_110.save!

    cs_110_ful = Fulfillment.new
    cs_110_ful.requirement = cs_110
    cs_110_ful.course = Course.find_by(course_name: 'CS110')
    cs_110_ful.save!

    cs_161 = Requirement.new(course_id: Course.find_by(course_name: 'CS161').id, num_courses: 1, priority: 4, repeatable: false)
    cs_161.category = core
    cs_161.save!

    cs_161_ful = Fulfillment.new
    cs_161_ful.requirement = cs_161
    cs_161_ful.course = Course.find_by(course_name: 'CS161')
    cs_161_ful.save!

    track = Category.new(show_name: 'Depth; Track and Electives', min_units: 25, min_courses: 7)
    track.track = hci
    track.save!

    cs_147 = Requirement.new(course_id: Course.find_by(course_name: 'CS147').id, num_courses: 1, priority: 4, repeatable: false)
    cs_147.category = track
    cs_147.save!

    cs_147_ful = Fulfillment.new
    cs_147_ful.requirement = cs_147
    cs_147_ful.course = Course.find_by(course_name: 'CS147')
    cs_147_ful.save!

    cs_247 = Requirement.new(course_id: Course.find_by(course_name: 'CS247').id, num_courses: 1, priority: 4, repeatable: false)
    cs_247.category = track
    cs_247.save!

    cs_247_ful = Fulfillment.new
    cs_247_ful.requirement = cs_247
    cs_247_ful.course = Course.find_by(course_name: 'CS247')
    cs_247_ful.save!

    track_b = Requirement.new(num_courses: 3, criteria: 'Track Requirement B', priority: 3, repeatable: false)
    track_b.category = track
    track_b.save!

    track_b_list = ['CS142', 'CS148', 'CS194H', 'CS210A', 'CS376', 'CS377A', 'CS377B', 'CS377C', 'CS377D']
    track_b_list += ['CS448B', 'ME216M', 'CS377E', 'CS377M', 'CS377U', 'CS377W']

    track_b_list.each do |elec|
        track_b_ful = Fulfillment.new
        track_b_ful.requirement = track_b
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        track_b_ful.course = Course.find_by(course_name: elec)
        track_b_ful.save!    
    end    

    track_c = Requirement.new(num_courses: 2, criteria: 'Track Requirement C', priority: 2, repeatable: false)
    track_c.category = track
    track_c.save!

    track_c_list = track_b_list
    track_c_list += ['COMM121', 'COMM124', 'COMM224', 'COMM140', 'COMM240', 'COMM166', 'COMM169', 'COMM269', 'COMM172', 'COMM272', 'COMM182', 'COMM324']
    track_c_list += ['ARTSTUDI160', 'ARTSTUDI162', 'ARTSTUDI163', 'ARTSTUDI164', 'ARTSTUDI165', 'ARTSTUDI168', 'ARTSTUDI264', 'ARTSTUDI266', 'ARTSTUDI267']
    track_c_list += ['SYMSYS245', 'PSYCH30', 'PSYCH45', 'PSYCH55', 'PSYCH70', 'PSYCH75', 'PSYCH110', 'PSYCH131', 'PSYCH154']
    track_c_list += ['MS&E125', 'PSYCH252', 'PSYCH254', 'PSYCH110', 'STATS203', 'EDUC191X', 'HUMBIO82A']
    track_c_list += ['ME101', 'ME115A', 'ME203', 'ME210', 'ME216A', 'EDUC281X', 'EDUC239X', 'EDUC338X', 'EDUC342', 'MS&E185', 'MS&E331']
    track_c_list += ['MUSIC220A', 'MUSIC220B', 'MUSIC220C', 'MUSIC250A']
    track_c_list = track_c_list.uniq

    track_c_list.each do |elec|
        track_c_ful = Fulfillment.new
        track_c_ful.requirement = track_c
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        track_c_ful.course = Course.find_by(course_name: elec)
        track_c_ful.save!    
    end  

    proj = Category.new(show_name: 'Senior Project', min_units: 3, min_courses: 1)
    proj.track = hci
    proj.save!

    proj_elec = Requirement.new(num_courses: 1, criteria: 'Senior Project', priority: 4, repeatable: false)
    proj_elec.category = proj
    proj_elec.save!

    proj_elec_list = ['CS191', 'CS191W', 'CS194', 'CS194W', 'CS194H', 'CS210B', 'CS294', 'CS294W']

    proj_elec_list.each do |elec|
        proj_elec_ful = Fulfillment.new
        proj_elec_ful.requirement = proj_elec
        if Course.find_by(course_name: elec) == nil then 
            Course.create(course_name: elec)
        end
        proj_elec_ful.course = Course.find_by(course_name: elec)
        proj_elec_ful.save!    
    end  

  end

  def down
  end
end
