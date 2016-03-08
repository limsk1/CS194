class Course < ActiveRecord::Base
  has_many :takens
  has_many :likes
  has_many :fulfillments
  validates :course_name, :presence => true
end
