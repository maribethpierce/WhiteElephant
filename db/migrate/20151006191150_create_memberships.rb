class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :group, null: false
      t.belongs_to :user, null: false
      t.index [:group_id, :user_id], unique: true
      t.timestamps
    end
  end
end
