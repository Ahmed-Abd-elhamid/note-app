class CreateCollaborations < ActiveRecord::Migration[6.0]
  def change
    create_table :collaborations do |t|
      t.references :note, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :can_edit, default: false

      t.timestamps
    end
  end
end
