class Report < ActiveRecord::Base
  validates :title, :description, :body, :location, presence: true
  validates :title, :location, length: { minimum: 2 }
  validates :description, length: { minimum: 10 }
  validates :location, format: { with: /\A[a-zA-Z\s]*\z/, message: 'should contains only letters' }

  has_many :categories_reports,  dependent: :destroy
  has_many :categories, through: :categories_reports
  has_many :ratings, dependent: :destroy

  belongs_to :user

  has_many :media, -> { order('position ASC') }, dependent: :destroy
  accepts_nested_attributes_for :media, allow_destroy: true, reject_if: :all_blank

  before_save :calculate_rating

  private

  def calculate_rating
    rating = self.ratings.inject(0) {|sum, i| sum + i.rating } / self.ratings.size
  end
end
