class Course < ActiveRecord::Base
  has_many :takens
  has_many :fulfillments
  validates :course_name, :presence => true
end
