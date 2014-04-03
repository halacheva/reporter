class AddRatingToReports < ActiveRecord::Migration
  def change
    add_column :reports, :rating, :decimal, default: 0
  end
end
