class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|
      # カラム追加(not null制約,default値)
      t.string :name,       null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
