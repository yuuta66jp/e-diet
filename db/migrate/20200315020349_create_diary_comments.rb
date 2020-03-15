class CreateDiaryComments < ActiveRecord::Migration[5.2]
  def change
    create_table :diary_comments do |t|
      # カラム追加(not null制約,外部キー設定)
      t.references :user,      null: false, foreign_key: true
      t.references :diary,     null: false, foreign_key: true
      t.string     :content,   null: false

      t.timestamps
    end
  end
end
