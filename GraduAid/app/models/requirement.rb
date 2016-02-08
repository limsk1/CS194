class Requirement < ActiveRecord::Base
  belongs_to :category
  has_many :fulfillments
end
