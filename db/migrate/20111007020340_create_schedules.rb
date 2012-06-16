class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.timestamp :datetime
      t.string :title
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
