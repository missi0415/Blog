class Book < ApplicationRecord

    belongs_to :user
    belongs_to :category
    attachment :image
    has_many :comments, dependent: :destroy
    has_many :likes, dependent: :destroy

    def liked_by?(user)
        likes.where(user_id: user.id).exists?
    end

    validates :title, presence: true, length: {maximum: 30}
    validates :author, presence: true, length: {maximum: 30}
    validates :body, presence: true
    validates :image, presence: true

end
