class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'

  after_save :update_post_counter

  validate :title, presence: true, length: { maximum: 250 }
  validate :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_post_counter
    author.update(posts_counter: author.posts.all.count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
