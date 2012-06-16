class Schedule < ActiveRecord::Base
  validates_presence_of :title
	paginates_per 3
	belongs_to(:user)
end
