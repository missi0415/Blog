require 'rails_helper'

describe 'ユーザログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end

      it 'トップページが表示されること' do
        expect(page).to have_content('新規登録')
      end

      it '新規登録のリンク先が正しい' do
        find('.btn').click
        expect(current_path).to eq new_user_registration_path
      end

      it 'ログインのリンク先が正しい' do
        find('#login').click
        expect(current_path).to eq new_user_session_path
      end

    end

    context '新規登録のテスト' do
      before do
        visit new_user_registration_path
        fill_in 'user_name', with: 'テスト'
        fill_in 'user_email', with: 'testtest@example.com'
        fill_in 'user_password', with: 'testtest'
        fill_in 'user_password_confirmation', with: 'testtest'
        click_button '登録'
      end

      it '新規登録ができること' do
        expect(page).to have_content('登録が完了しました。')
      end

      it 'メールアドレスは一意であること' do
        find('#signout').click
        visit new_user_registration_path
        fill_in 'user_name', with: 'テスト2'
        fill_in 'user_email', with: 'testtest@example.com'
        fill_in 'user_password', with: 'testtest'
        fill_in 'user_password_confirmation', with: 'testtest'
        click_button '登録'
        expect(page).to have_content('Eメールはすでに存在します')
      end

    end
  end
end