FactoryBot.define do

  factory :user_test, class: 'User' do
    name     { Faker::Name.unique.name }
    email    { Faker::Internet.unique.email }
    password { 'password' }
  end

end