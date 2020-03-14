class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.references :genre, null: false, foreign_key: true
      t.string     :title, null: false
      t.text       :body,  null: false
      t.string     :topic_image_id

      t.timestamps
    end
  end
end
