class CreateBodyWeights < ActiveRecord::Migration[5.2]
  def change
    create_table :body_weights do |t|
      # カラム追加(not null制約,default値,外部キー設定)
      t.references :user,   null: false, foreign_key: true
      t.references :diary,  null: false, foreign_key: true
      t.integer    :record, null: false

      t.timestamps
    end
  end
end
