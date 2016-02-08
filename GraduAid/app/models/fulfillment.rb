class Fulfillment < ActiveRecord::Base
    belongs_to :requirement
    belongs_to :course
end
