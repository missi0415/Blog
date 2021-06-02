Category.create!(
  name: "ruby"
)
Category.create!(
  name: "python"
)
Category.create!(
  name: "php"
)
Category.create!(
  name: "Java"
)
Category.create!(
  name: "JavaScript"
)
Category.create!(
  name: "Go"
)

Book.create!(
  title: "ITパスポート",
  author: "きたみ",
  category_id: 1,
  body: "資格試験の参考書です"
)