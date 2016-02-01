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
    hci.courses << cs107
    hci.courses << cs103
    hci.courses << cs109
    hci.courses << cs147
    hci.save!

    sys = Track.new(name: 'CS-Systems')
    sys.courses << cs107
    sys.courses << cs103
    sys.courses << cs109
    sys.courses << cs140
    sys.save!

    info = Track.new(name: 'CS-Information')
    info.courses << cs107
    info.courses << cs103
    info.courses << cs109
    info.courses << cs145
    info.save!

    sample = User.new(email: 'limsk1@stanford.edu', first_name: 'Sunkyu', last_name: 'Lim')
    sample.track = sys
    sample.courses << cs107
    sample.courses << cs109
    sample.courses << cs140
    puts sample.track.name
    sample.save!

  end

  def down
    User.delete_all
    Course.delete_all
    Track.delete_all
  end
end
