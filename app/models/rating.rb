class Rating < ActiveRecord::Base
  belongs_to :users
  belongs_to :reports
end
