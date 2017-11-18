class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :project, foreign_key: true
      t.string :title
      t.boolean :done, default: false
      t.integer :position
      t.datetime :deadline

      t.timestamps
    end
  end
end
