require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントバリデーションのテスト' do
    User.create(
      name:     Faker::Name.unique.name,
      email:    Faker::Internet.unique.email,
      password: 'password'
    )
    Book.create(
      user_id:     1,
      title:       Faker::Book.title,
      author:      Faker::Book.author,
      category_id: 1,
      body:        'djangoの参考書です。',
      image_id:    '993f0953c1950c9bc8b382b2ab7998166f16437593d83db745f976e25d98'
    )
    let (:comment) {build(:comment)}

    it 'バリデーションが有効なこと' do
      expect(comment).to be_valid
    end

    context 'コメントのバリデーション' do

      it 'コメントが空でないこと' do
        comment.comment = ''
        expect(comment).to be_invalid
      end

    end
  end
end