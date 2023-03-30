class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'

  after_save :update_post_counter

  def update_post_counter
    author.update(posts_counter: author.posts.all.count)
  end

  def most_recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
