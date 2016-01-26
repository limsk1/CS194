class Course < ActiveRecord::Base
  has_many :requirements
  validates :course_name, :presence => true
end
