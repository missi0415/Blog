FactoryBot.define do

  factory :category, class: 'Category' do
    id {1}
    name { Faker::Name.unique.name }
  end

end