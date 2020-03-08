class CreateDiaries < ActiveRecord::Migration[5.2]
  def change
    create_table :diaries do |t|
      # カラム追加(not null制約,default値,外部キー設定)
      t.references :user, null: false, foreign_key: true
      t.text       :remark
      t.integer    :activity_status

      t.timestamps
    end
  end
end
