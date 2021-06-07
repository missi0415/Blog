class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  attachment :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  validates :name, presence: true, length: {maximum: 30}
  validates :email, uniqueness: true, length: {maximum: 50}
  validates :introduction, presence: true, length: {maximum: 200}

  def update_without_current_password(params, *options)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  def follow(other_user)
    unless self == other_user
      self.relationships.create(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  # idハッシュ化
  include Hashid::Rails

end
