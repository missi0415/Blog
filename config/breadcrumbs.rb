crumb :root do
  link "トップページ", root_path
end

crumb :user_index do
  link "ユーザー一覧", users_path
end

crumb :user_show do |user|
  if params[:controller] == "chats"
    user = User.find(params[:id])
  elsif params[:action] == "following" || params[:action] == "followers"
    user = User.find(params[:user_id])
  elsif params[:action] == "edit"
    user = User.find(params[:format])
  elsif params[:commit] == "更新"
    user = current_user
  end

  if user.name == current_user.name
    link "マイページ", user_path(user)
  else
    link "#{user.name} さんの詳細", user_path(user)
  end
  parent :user_index
end

crumb :user_edit do
  link "プロフィール編集", edit_user_registration_path(current_user)
  parent :user_show
end

crumb :following do |user|
  link "#{user.name} さんのフォロー", user_following_path(user)
  parent :user_show
end

crumb :followers do |user|
  link "#{user.name} さんのフォロワー", user_followers_path(user)
  parent :user_show
end

crumb :chat do |user|
  link "#{user.name} さんとのチャット", chat_path(user.chats)
  parent :user_show
end

crumb :book_index do
  link "投稿書籍一覧", books_path
end

crumb :book_show do |book|
  link "#{book.title} の詳細", book_path(book)
  parent :book_index
end

crumb :book_search do |book|
  link "#{params[:keyword]} の検索結果", search_path
  parent :book_index
end

crumb :book_new do
  link "投稿フォーム", new_book_path
end

crumb :category_index do
  link "カテゴリ一覧", categories_path
end

crumb :category_show do |category|
  link "#{category.name} の詳細", category_path(category)
  parent :category_index
end



# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).