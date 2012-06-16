class CreateMembers < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.column(:group_id, :integer)
      t.column(:name, :string)

      t.timestamps
    end
  end

  def self.down
    drop_table :members
  end
end
