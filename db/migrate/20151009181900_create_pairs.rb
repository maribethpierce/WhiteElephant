class CreatePairs < ActiveRecord::Migration
  def change
    create_table :pairs do |t|
      t.integer :santa, null: false
      t.integer :recipient, null: false
      t.boolean :locked, default: false
      t.belongs_to :group
    end
  end
end
