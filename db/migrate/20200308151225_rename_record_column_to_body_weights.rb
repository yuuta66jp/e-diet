class RenameRecordColumnToBodyWeights < ActiveRecord::Migration[5.2]
  def change
    rename_column :body_weights, :record, :weight_record
  end
end
