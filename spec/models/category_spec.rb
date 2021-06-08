require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'カテゴリバリデーションのテスト' do
    let (:category) {build(:category)}

    it 'バリデーションが有効なこと' do
      expect(category).to be_valid
    end

    context 'カテゴリのバリデーション' do
      it '名前が空でないこと' do
        category.name = ''
        expect(category).to be_invalid
      end

    end
  end
end