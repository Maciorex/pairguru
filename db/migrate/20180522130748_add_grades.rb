class AddGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.integer :value
      t.references :user, index: true, foreign_key: true
      t.references :movie, index: true, foreign_key: true
    end
  end
end
