# == Schema Information
#
# Table name: schedules
#
#  id         :integer          not null, primary key
#  datetime   :datetime
#  title      :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  file_name  :string(255)
#  user_id    :integer
#  group_id   :integer
#

class Schedule < ActiveRecord::Base
  validates_presence_of :title
	paginates_per 3
	belongs_to(:user)
end
