class Book < ApplicationRecord

    belongs_to :user
    belongs_to :category
    attachment :image

    validates :title, presence: true, length: {maximum: 30}
    validates :author, presence: true, length: {maximum: 30}
    validates :body, presence: true
    validates :image_id, presence: true

end
