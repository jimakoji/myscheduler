# == Schema Information
#
# Table name: groups
#
#  id   :integer          not null, primary key
#  name :string(255)
#

class Group < ActiveRecord::Base
  paginates_per 4
  has_many(:members)
	has_many(:users)
end
