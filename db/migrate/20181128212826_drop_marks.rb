class DropMarks < ActiveRecord::Migration[5.2]
  def change
    drop_table :marks
  end
end