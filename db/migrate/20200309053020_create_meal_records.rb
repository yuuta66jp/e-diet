class CreateMealRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :meal_records do |t|
      # カラム追加(not null制約,default値,外部キー設定)
      t.references :diary,         null: false, foreign_key: true
      t.string     :title,         null: false
      t.text       :body
      t.string     :meal_image_id, null: false
      t.integer    :intake_status, null: false

      t.timestamps
    end
  end
end
