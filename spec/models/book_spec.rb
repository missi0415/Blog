require 'rails_helper'

RSpec.describe Book, type: :model do
  describe '書籍バリデーションのテスト' do
    let (:category) {FactoryBot.build(:category)}
    let (:book) {FactoryBot.build(:book)}

    it 'バリデーションが有効なこと' do
      expect(book).to be_valid
    end

    context 'タイトルのバリデーション' do

      it 'タイトルが空でないこと' do
        book.title = ''
        expect(book).to be_invalid
      end

      it 'タイトルが31文字以上でないこと' do
        book.title = 'x' * 31
        expect(book).to be_invalid
      end

      it 'タイトルが30文字以下であること' do
        book.title = 'x' * 30
        expect(book).to be_valid
      end

    end

    context '著者のバリデーション' do

      it '著者が空でないこと' do
        book.author = ''
        expect(book).to be_invalid
      end

      it '著者が31文字以上でないこと' do
        book.author = 'x' * 31
        expect(book).to be_invalid
      end

      it '著者が30文字以下であること' do
        book.author = 'x' * 30
        expect(book).to be_valid
      end

    end

    context '説明のバリデーション' do

      it '説明が空でないこと' do
        book.body = ''
        expect(book).to be_invalid
      end

    end

    context '画像のバリデーション' do

      it '画像が空でないこと' do
        book.image_id = ''
        expect(book).to be_invalid
      end

    end
  end
end