require 'rails_helper'

@user = User.find(11)

describe 'ユーザログイン後のテスト' do
  describe '書籍一覧のテスト' do
    before do
      visit new_user_registration_path
      fill_in 'user_name', with: 'テスト'
      fill_in 'user_email', with: 'tes@example.com'
      fill_in 'user_password', with: 'testtest'
      fill_in 'user_password_confirmation', with: 'testtest'
      click_button '登録'
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq books_path
      end

      it '表示内容が正しい' do
        expect(page).to have_content('トップページ > 投稿書籍一覧')
      end

      it '投稿記事の詳細ページへのリンク先が正しい' do
        find('#books7').click
        expect(current_path).to eq book_path(7)
      end
    end

    context 'マイページのテスト' do
      it 'マイページへのリンク先が正しい' do
        find('#mypage').click
        expect(current_path).to eq '/users/bznt1b'
      end

      before do
        visit '/users/bznt1b'
      end

      it 'マイページの表示が正しい' do
        expect(page).to have_content('マイページ')
      end

      it 'プロフィール編集ボタンが表示されること' do
        expect(page).to have_content('プロフィール編集')
      end

      it 'マイページにフォローするボタンは表示されないこと' do
        expect(page).to_not have_content('フォローする')
      end

    end

    context 'プロフィール編集のテスト' do
      it 'プロフィール編集ボタンでプロフィール編集画面へ遷移すること' do
        visit '/users/bznt1b'
        click_on 'プロフィール編集'
        expect(current_path).to eq "/users/edit.bznt1b"
      end

      before do
        visit "/users/edit.bznt1b"
      end

      it 'パンくずリストの表示が正しい' do
        expect(page).to have_content('トップページ > ユーザー一覧 > マイページ > プロフィール編集')
      end

      it 'パスワードの入力なしで更新できること' do
        fill_in 'user_name', with: 'テスト変更'
        click_button '更新'
        expect(page).to have_content('アカウント情報を変更しました')
      end

      it 'パスワードの更新ができること' do
        fill_in 'user_password', with: 'henkou'
        fill_in 'user_password_confirmation', with: 'henkou'
        click_button '更新'
        expect(page).to have_content('アカウント情報を変更しました')

        find('#signout').click
        visit new_user_session_path
        fill_in 'user_email', with: 'tes@example.com'
        fill_in 'user_password', with: 'henkou'
        click_button 'ログイン'
        expect(page).to have_content('ログインしました')
      end

      it 'パスワードが5文字以下の時エラーメッセージが表示されること' do
        fill_in 'user_password', with: 'x' * 5
        fill_in 'user_password_confirmation', with: 'x' * 5
        click_button '更新'
        expect(page).to have_content('パスワードは6文字以上で入力してください')
      end

      it '戻るボタンを押すと1ページ前へ遷移すること' do
        visit '/users/bznt1b'
        click_on 'プロフィール編集'
        click_on '戻る'
        expect(current_path).to eq '/users/bznt1b'
      end

      it '退会するボタンを押すと退会できること' do
        click_on '退会する'
        expect(page).to have_content('アカウントを削除しました。')
      end
    end

    context 'ユーザー一覧のテスト' do
      it 'ヘッダーのリンク先が正しいこと' do
        find('#users').click
        expect(current_path).to eq users_path
      end

      before do
        visit users_path
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧')
      end

      it 'ユーザー一覧の表示が正しいこと' do
        expect(page).to have_content(User.find(11).name)
        expect(page).to have_content(User.find(12).name)
      end

      it 'ユーザーのユーザー詳細へのリンク先が正しいこと' do
        find('#users11').click
        expect(current_path).to eq "/users/boztvx"
        expect(page).to have_content(User.find(11).name)
      end
    end

    context 'ユーザー詳細ページのテスト' do
      before do
        visit "/users/boztvx"
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧 > '+ User.find(11).name + ' さんの詳細')
      end

      it 'チャットボタンが表示されること' do
        expect(page).to have_content('チャット')
      end

      it 'フォローするボタンが表示されること' do
        expect(page).to have_content('フォローする')
      end

      it 'ユーザーの表示が正しいこと' do
        expect(page).to have_content(User.find(11).name + 'のページ')
        expect(page).to have_content(User.find(11).introduction)
      end

      it 'フォローするボタンを押すとフォローができること' do
        click_on 'フォローする'
        expect(page).to have_content('フォローしました')
      end

      it 'フォロー解除ボタンを押すとフォローが解除できること' do
        click_on 'フォローする'
        click_on 'フォロー解除'
        expect(page).to have_content('フォローを解除しました')
      end

      it 'フォローするとフォロワーの表示が1増えること' do
        expect(page).to have_content('フォロワー 0')
        click_on 'フォローする'
        expect(page).to have_content('フォロワー 1')
      end

      it 'チャットボタンを押すとチャットページへ遷移すること' do
        click_on 'チャット'
        expect(page).to have_content(User.find(11).name + ' さんとのチャット')
      end
    end

    context 'チャットのテスト' do
      before do
        visit chat_path(11)
      end

      it 'チャットが投稿できること' do
        fill_in 'chat_message', with: 'チャット'
        click_button '投稿'
        expect(page).to have_content('チャット')
      end
    end

  end
end