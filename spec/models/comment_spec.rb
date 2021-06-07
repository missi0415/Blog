require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメントバリデーションのテスト' do
    let (:comment) { FactoryBot.build(:comment)}

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