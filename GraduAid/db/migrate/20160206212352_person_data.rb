class PersonData < ActiveRecord::Migration
  def up
    user_1 = User.new(email: 'limsk1@stanford.edu', first_name: 'Sunkyu', last_name: 'Lim')
    user_1.track = Track.find_by(name: 'CS-AI')
    user_1.save!

    taken_1 = Taken.new(grade: 'A', unit: 5)
    taken_1.user = user_1
    taken_1.course = Course.find_by(course_name: 'CS107')
    taken_1.save!

    taken_2 = Taken.new(grade: 'A-', unit: 5)
    taken_2.user = user_1
    taken_2.course = Course.find_by(course_name: 'CS221')
    taken_2.save!

    taken_3 = Taken.new(grade: 'A+', unit: 5)
    taken_3.user = user_1
    taken_3.course = Course.find_by(course_name: 'CS103')
    taken_3.save!

    taken_4 = Taken.new(grade: 'B+', unit: 3)
    taken_4.user = user_1
    taken_4.course = Course.find_by(course_name: 'CS223A')
    taken_4.save!

    taken_5 = Taken.new(grade: 'A', unit: 3)
    taken_5.user = user_1
    taken_5.course = Course.find_by(course_name: 'CS224M')
    taken_5.save!

    taken_6 = Taken.new(grade: 'A-', unit: 4)
    taken_6.user = user_1
    taken_6.course = Course.find_by(course_name: 'CS224N')
    taken_6.save!
  end

  def down
  end
end
