class Group < ActiveRecord::Base
  paginates_per 4
  has_many(:members)
	has_many(:users)
end
