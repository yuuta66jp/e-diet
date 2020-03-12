class CreateRewards < ActiveRecord::Migration[5.2]
  def change
    create_table :rewards do |t|
      # カラム追加(not null制約,外部キー設定)
      t.references :user,      null: false, foreign_key: true
      t.integer :point,        null: false
      t.integer :issue_reason, null: false

      t.timestamps
    end
  end
end
