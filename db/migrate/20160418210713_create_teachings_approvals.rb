class CreateTeachingsApprovals < ActiveRecord::Migration
  def change
    create_table :teachings_approvals do |t|
      t.references :user, index: true, foreign_key: true
      t.references :teaching, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
