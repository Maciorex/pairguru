class AddIdsToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, index: true, foreign_key: true
    add_reference :comments, :movie, index: true, foreign_key: true
  end
end
