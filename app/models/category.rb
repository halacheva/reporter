class Category < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true, length: { minimum: 2 }

  has_many :categories_reports, dependent: :destroy
  has_many :reports, through: :categories_reports
end
