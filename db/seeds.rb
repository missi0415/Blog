User.create!(
  id: 1,
  name: "田中太郎",
  email: "taro@example.com",
  password: "tanakatarou",
  password_confirmation: "tanakatarou"
)
User.create!(
  id: 2,
  name: "山田太郎",
  email: "yamada@example.com",
  password: "yamadatarou",
  password_confirmation: "yamadatarou"
)
User.create!(
  id: 3,
  name: "佐藤彩",
  email: "aya@example.com",
  password: "satouaya",
  password_confirmation: "satouaya"
)
User.create!(
  id: 4,
  name: "鈴木奈緒",
  email: "nao@example.com",
  password: "suzukinao",
  password_confirmation: "suzukinao"
)
User.create!(
  id: 5,
  name: "古賀光",
  email: "hikaru@example.com",
  password: "kogahikaru",
  password_confirmation: "kogahikaru"
)
User.create!(
  id: 6,
  name: "大塚圭介",
  email: "ottu@example.com",
  password: "ootukakeisuke",
  password_confirmation: "ootukakeisuke"
)
User.create!(
  id: 7,
  name: "平井一輝",
  email: "hirai@example.com",
  password: "hiraikazuki",
  password_confirmation: "hiraikazuki"
)
User.create!(
  id: 8,
  name: "藤田遥",
  email: "haru@example.com",
  password: "hujitaharuka",
  password_confirmation: "hujitaharuka"
)
User.create!(
  id: 9,
  name: "高橋優花",
  email: "yuuka@example.com",
  password: "takahasiyuuka",
  password_confirmation: "takahasiyuuka"
)
User.create!(
  id: 10,
  name: "伴修二郎",
  email: "ban@example.com",
  password: "bansyuujirou",
  password_confirmation: "bansyuujirou"
)

["ruby", "python", "php", "Java", "JavaScript", "C", "C++", "Go"].each do |name|
  Category.create!(
    name: name
  )
end