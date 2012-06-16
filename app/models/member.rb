class Member < ActiveRecord::Base
  paginates_per 3
  belongs_to(:group)
end
