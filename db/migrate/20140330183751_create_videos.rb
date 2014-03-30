class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.timestamps
    end

    add_attachment :videos, :file
  end
end
