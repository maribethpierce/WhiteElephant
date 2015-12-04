class CreatePeeps < ActiveRecord::Migration
  def change
    create_table :peeps do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.belongs_to :group
    end
  end
end
