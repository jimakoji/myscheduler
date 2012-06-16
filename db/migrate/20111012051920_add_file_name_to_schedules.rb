class AddFileNameToSchedules < ActiveRecord::Migration
  def self.up
		add_column :schedules,:file_name,:string
  end

  def self.down
		remove_column :schedules, :file_name
  end
end
