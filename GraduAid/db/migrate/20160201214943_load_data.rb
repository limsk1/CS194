class LoadData < ActiveRecord::Migration
  def up
    cs107 = Course.new(course_name:'CS107')
    cs107.save!
    cs109 = Course.new(course_name:'CS109')
    cs109.save!
    cs103 = Course.new(course_name:'CS103')
    cs103.save!
    cs147 = Course.new(course_name:'CS147')
    cs147.save!
    cs140 = Course.new(course_name:'CS140')
    cs140.save!
    cs145 = Course.new(course_name:'CS145')
    cs145.save!

    hci = Track.new(name: 'CS-HCI')
    hci.save!

    sys = Track.new(name: 'CS-Systems')
    sys.save!

    info = Track.new(name: 'CS-Information')
    info.save!

    sample = User.new(email: 'limsk1@stanford.edu', first_name: 'Sunkyu', last_name: 'Lim')
    sample.track = sys
    puts sample.track.name
    sample.save!

    taken_1 = Taken.new(grade: 'A', unit: 5)
    taken_1.user = sample
    taken_1.course = cs107
    taken_1.save!

    taken_2 = Taken.new(grade: 'A-', unit: 5)
    taken_2.user = sample
    taken_2.course = cs140
    taken_2.save!

    taken_3 = Taken.new(grade: 'A+', unit: 5)
    taken_3.user = sample
    taken_3.course = cs109
    taken_3.save!

    requirement_1 = Requirement.new(criteria: 'Core')
    requirement_1.track = hci
    requirement_1.course = cs107
    requirement_1.save!

    requirement_2 = Requirement.new(criteria: 'Core')
    requirement_2.track = sys
    requirement_2.course = cs107
    requirement_2.save!

    requirement_3 = Requirement.new(criteria: 'Core')
    requirement_3.track = info
    requirement_3.course = cs107
    requirement_3.save!

    requirement_4 = Requirement.new(criteria: 'Math')
    requirement_4.track = hci
    requirement_4.course = cs103
    requirement_4.save!

    requirement_5 = Requirement.new(criteria: 'Math')
    requirement_5.track = sys
    requirement_5.course = cs103
    requirement_5.save!

    requirement_6 = Requirement.new(criteria: 'Math')
    requirement_6.track = info
    requirement_6.course = cs103
    requirement_6.save!

    requirement_7 = Requirement.new(criteria: 'Math')
    requirement_7.track = hci
    requirement_7.course = cs109
    requirement_7.save!

    requirement_8 = Requirement.new(criteria: 'Math')
    requirement_8.track = sys
    requirement_8.course = cs109
    requirement_8.save!

    requirement_9 = Requirement.new(criteria: 'Math')
    requirement_9.track = info
    requirement_9.course = cs109
    requirement_9.save!

    requirement_10 = Requirement.new(criteria: 'Track Requirement A')
    requirement_10.track = hci
    requirement_10.course = cs147
    requirement_10.save!

    requirement_11 = Requirement.new(criteria: 'Track Requirement A')
    requirement_11.track = sys
    requirement_11.course = cs140
    requirement_11.save!

    requirement_12 = Requirement.new(criteria: 'Track Requirement A')
    requirement_12.track = info
    requirement_12.course = cs145
    requirement_12.save!

  end

  def down
    User.delete_all
    Course.delete_all
    Track.delete_all
    Taken.delete_all
    Requirement.delete_all
  end
end
