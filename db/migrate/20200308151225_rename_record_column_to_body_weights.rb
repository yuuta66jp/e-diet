class RenameRecordColumnToBodyWeights < ActiveRecord::Migration[5.2]
  def change
    # recordカラムが使えないため変更（カラム名重複エラーにより）
    rename_column :body_weights, :record, :weight_record
  end
end
