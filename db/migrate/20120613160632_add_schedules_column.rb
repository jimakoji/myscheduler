class AddSchedulesColumn < ActiveRecord::Migration
  def self.up
		add_column :schedules, :user_id, :integer
		add_column :schedules, :group_id, :integer
  end

  def self.down
		remove_column :schedules, :user_id
		remove_column :schedules, :user_id
  end
end
