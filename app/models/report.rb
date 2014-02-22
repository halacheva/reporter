class Report < ActiveRecord::Base
  validates :title, :description, :body, :location, presence: true
  validates :title, :location, length: { minimum: 2 }
  validates :description, length: { minimum: 10 }
  validates :location, format: { with: /\A[a-zA-Z\s]*\z/, message: 'should contains only letters' }

  has_and_belongs_to_many :categories
end
