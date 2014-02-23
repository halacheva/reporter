class CategoriesReport < ActiveRecord::Base
  belongs_to  :category
  belongs_to  :report
end
