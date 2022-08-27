class Post < ApplicationRecord
  belongs_to :user
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :book_marks, dependent: :destroy
  has_many :comments, dependent: :destroy

  def book_marked_by?(user)
    book_marks.where(user_id: user).exists?
  end

  validates :title, presence: true
  validates :purpose, presence: true
  validates :star, presence: true

  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :star_count, -> {order(star: :desc)}
end
