class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name, null: false
      t.string :description
      t.belongs_to :user, null: false
      t.timestamps
    end
  end
end
