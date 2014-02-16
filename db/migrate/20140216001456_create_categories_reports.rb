# Create many to many asociations table
class CreateCategoriesReports < ActiveRecord::Migration
  def change
    create_table :categories_reports do |t|
      t.belongs_to :category
      t.belongs_to :report
    end
  end
end
