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

require 'test_helper'

class ScheduleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
end
