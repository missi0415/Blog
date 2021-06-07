require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーバリデーションのテスト' do
    let(:user_test) { build(:user_test) }
    let!(:other_user) { create(:user_test) }

    it 'バリデーションが有効なこと' do
      expect(user_test).to be_valid
    end

    context 'メールアドレスのバリデーション' do

      it 'メールアドレスが空欄でないこと' do
        user_test.email = ''
        expect(user_test).to be_invalid
      end

      it 'メールアドレスが一意であること' do
        user_test.name = other_user.name
        is_expected.to eq false
      end

      it 'メールアドレスが51字以上でないこと' do
        user_test.email = 'x' * 39 + '@example.com'
        expect(user_test).to be_invalid
      end

      it 'メールアドレスが50字以下であること' do
        user_test.email = 'x' * 38 + '@example.com'
        expect(user_test).to be_valid
      end

    end

    context '名前のバリデーション' do

      it '名前が空欄でないこと' do
        user_test.name = ''
        expect(user_test).to be_invalid
      end

      it '名前が31文字以上でないこと' do
        user_test.name = 'x' * 31
        expect(user_test).to be_invalid
      end

      it '名前が30文字以下であること' do
        user_test.name = 'x' * 30
        expect(user_test).to be_valid
      end

    end

    context '紹介文のバリデーション' do

      it '紹介文が空でないこと' do
        user_test.introduction = ''
        expect(user_test).to be_invalid
      end

      it '紹介文が201文字以上でないこと' do
        user_test.introduction = 'x' * 201
        expect(user_test).to be_invalid
      end

      it '紹介文が200文字以上であること' do
        user_test.introduction = 'x' * 200
        expect(user_test).to be_valid
      end

    end

    context 'パスワードのバリデーション' do
      it 'パスワードが5文字以下でないこと' do
        user_test.password = 'x' * 5
        expect(user_test).to be_invalid
      end

      it 'パスワードが6文字以上であること' do
        user_test.password = 'x' * 6
        expect(user_test).to be_valid
      end

    end
  end
end