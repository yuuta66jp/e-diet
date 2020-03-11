class AddCreatedOnToDiaries < ActiveRecord::Migration[5.2]
  def change
    # カラム追加(not null制約)
    add_column :diaries, :created_on, :date
  end
end
