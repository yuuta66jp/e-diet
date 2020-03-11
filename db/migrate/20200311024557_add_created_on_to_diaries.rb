class AddCreatedOnToDiaries < ActiveRecord::Migration[5.2]
  def change
    add_column :diaries, :created_on, :date
  end
end
