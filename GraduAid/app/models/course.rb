class Course < ActiveRecord::Base
  has_many :takens
  validates :course_name, :presence => true
end
