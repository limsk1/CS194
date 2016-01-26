class Requirement < ActiveRecord::Base
  belong_to :track
  belong_to :course
end
