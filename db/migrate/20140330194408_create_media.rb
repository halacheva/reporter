class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.integer :report_id
      t.string :label

      t.references :attachable, polymorphic: true
      t.timestamps
    end
  end
end
