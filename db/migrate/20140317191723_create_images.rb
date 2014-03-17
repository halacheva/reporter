class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :report_id
      t.string :label

      t.timestamps
    end

    add_attachment :images, :file
  end
end
