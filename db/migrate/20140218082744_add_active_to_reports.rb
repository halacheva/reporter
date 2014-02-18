# Add active column to reports
class AddActiveToReports < ActiveRecord::Migration
  def change
    add_column :reports, :active, :boolean
  end
end
