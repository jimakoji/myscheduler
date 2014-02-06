# == Schema Information
#
# Table name: members
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class Member < ActiveRecord::Base
  paginates_per 3
  belongs_to(:group)
end
