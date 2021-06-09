require 'rails_helper'

describe 'ユーザログイン後のテスト' do
  describe '書籍一覧のテスト' do
    before do
      visit new_user_registration_path
      fill_in 'user_name', with: Faker::Name.unique.name
      fill_in 'user_email', with: Faker::Internet.unique.email
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
        find("#books#{Book.last.id}").click
        expect(current_path).to eq book_path(Book.last.id)
      end
    end

    context 'マイページのテスト' do
      it 'マイページへのリンク先が正しい' do
        find('#mypage').click
        expect(current_path).to eq user_path(User.last.id)
      end

      before do
        visit user_path(User.last.id)
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
        visit user_path(User.last.id)
        click_on 'プロフィール編集'
        expect(current_path).to eq "/users/edit.#{User.last.id}"
      end

      before do
        visit "/users/edit.#{User.last.id}"
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
        fill_in 'user_email', with: User.last.email
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
        visit user_path(User.last.id)
        click_on 'プロフィール編集'
        click_on '戻る'
        expect(current_path).to eq user_path(User.last.id)
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
        expect(page).to have_content(User.find(User.last.id - 1).name)
        expect(page).to have_content(User.last.name)
      end

      it 'ユーザーのユーザー詳細へのリンク先が正しいこと' do
        find("#users#{User.last.id}").click
        expect(current_path).to eq user_path(User.last.id)
        expect(page).to have_content("マイページ")
      end
    end

    context 'ユーザー詳細ページのテスト' do
      before do
        visit user_path(User.last.id - 1)
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧 > '+ User.find(User.last.id - 1).name + ' さんの詳細')
      end

      it 'チャットボタンが表示されること' do
        expect(page).to have_content('チャット')
      end

      it 'フォローするボタンが表示されること' do
        expect(page).to have_content('フォローする')
      end

      it 'ユーザーの表示が正しいこと' do
        expect(page).to have_content(User.find(User.last.id - 1).name + 'のページ')
        expect(page).to have_content(User.find(User.last.id - 1).introduction)
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

      it 'フォローするとフォローの表示が1増えること' do
        visit user_path(User.last.id)
        expect(page).to have_content('フォロー 0')
        visit user_path(User.last.id - 1)
        click_on 'フォローする'
        visit user_path(User.last.id)
        expect(page).to have_content('フォロー 1')
      end

      it 'チャットボタンを押すとチャットページへ遷移すること' do
        click_on 'チャット'
        expect(page).to have_content(User.find(User.last.id - 1).name + ' さんとのチャット')
      end
    end

    context 'チャットのテスト' do
      before do
        visit chat_path(User.last.id - 1)
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧 > ' + User.find(User.last.id - 1).name + ' さんの詳細 > ' + User.find(User.last.id - 1).name + ' さんとのチャット')
      end
    end

    context 'フォローのテスト' do
      before do
        visit user_path(User.last.id - 1)
        click_on 'フォローする'
        visit "/users/#{User.last.id}/following"
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧 > マイページ > ' + User.find(User.last.id).name + ' さんのフォロー')
      end

      it 'フォローの表示が正しい' do
        expect(page).to have_content(User.find(User.last.id - 1).name)
      end
    end

    context 'フォロワーのテスト' do
      before do
        visit user_path(User.last.id - 1)
        click_on 'フォローする'
        visit user_followers_path(User.last.id - 1)
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > ユーザー一覧 > ' + User.find(User.last.id - 1).name + ' さんの詳細 > ' + User.find(User.last.id - 1).name + ' さんのフォロワー')
      end

      it 'フォロワーの表示が正しい' do
        expect(page).to have_content(User.last.name)
        expect(page).to have_content('フォロワー 1')
      end
    end

    context '書籍投稿のテスト' do
      it '投稿フォームに遷移すること' do
        find('#book_new').click
        expect(current_path).to eq new_book_path
      end

      before do
        visit new_book_path
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > 投稿フォーム')
      end

      it '内容を入力しないとエラーメッセージが表示されること' do
        click_button '登録'
        expect(page).to have_content('カテゴリを入力してください')
        expect(page).to have_content('タイトルを入力してください')
        expect(page).to have_content('著者を入力してください')
        expect(page).to have_content('内容を入力してください')
        expect(page).to have_content('画像を入力してください')
      end
    end

    context 'カテゴリ一覧のテスト' do
      it 'カテゴリ一覧へ遷移すること' do
        find('#category_index').click
        expect(current_path).to eq categories_path
      end

      before do
        visit categories_path
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > カテゴリ一覧')
      end

      it 'カテゴリ一覧が表示されていること' do
        new_category = Category.new(
          name: "テスト"
        )
        new_category.save
        visit current_path
        expect(page).to have_content(Category.last.name)
      end

      it 'カテゴリ詳細へのリンク先が正しいこと' do
        find("#category#{Category.last.id}").click
        expect(current_path).to eq category_path(Category.last.id)
      end
    end

    context 'カテゴリ詳細のテスト' do
      before do
        visit category_path(1)
      end

      it 'パンくずリストの表示が正しいこと' do
        expect(page).to have_content('トップページ > カテゴリ一覧 > ' + Category.first.name + ' の詳細')
      end

      it 'カテゴリ詳細の表示が正しいこと' do
        expect(page).to have_content(Book.find_by(category_id: Category.first.id).title)
        expect(page).to have_content(Book.find_by(category_id: Category.first.id).author)
        expect(page).to have_content(Book.find_by(category_id: Category.first.id).body)
        expect(page).to have_content(Book.find_by(category_id: Category.first.id).user.name)
      end
    end

    context '検索ページのテスト' do
      it 'コントローラーがブックのページだけ検索フォームが表示されること' do
        expect(page).to have_css('#search_form')
        visit new_book_path
        expect(page).to have_css('#search_form')
        visit book_path(1)
        expect(page).to have_css('#search_form')
      end

      it '検索結果が正しいこと' do
        find('.form-control.w-75').set(Book.first.title)
        click_button '検索'
        expect(page).to have_content(Book.first.title + ' の検索結果')
        expect(page).to have_content(Book.first.author)
      end

      it '何も入力せず検索すると書籍一覧へ遷移すること' do
        visit new_book_path
        click_button '検索'
        expect(current_path).to eq books_path
      end
    end

  end
end