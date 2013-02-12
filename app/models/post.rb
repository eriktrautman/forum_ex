class Post < ActiveRecord::Base
  attr_accessible :author_id, :body, :title

  validates :author_id, presence: true
  validates :body, length: { in: 1..1024 }
  validates :title, length: { in: 1..64 }

  has_many :comments, dependent: :destroy
  belongs_to :author, class_name: "User", foreign_key: :author_id

  def comments_for(user)
    self.comments.where("author_id = ?", user.id)
  end

  def self.commented_or_created_by(user)
    self
      .joins("LEFT JOIN comments ON posts.id = comments.post_id")
      .where("comments.author_id = ? OR posts.author_id = ?",user.id, user.id)
      .group("posts.id")
  end

end
