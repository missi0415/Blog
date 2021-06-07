FactoryBot.define do

  factory :user_test, class: 'User' do
    name          { Faker::Name.unique.name }
    email         { Faker::Internet.unique.email }
    password      { 'password' }
  end

  factory :category, class: 'Category' do
    id            {1}
    name          {'django'}
  end

  factory :book, class: 'Book' do
    user_id       {'11'}
    title         { Faker::Book.title }
    author        { Faker::Book.author }
    category_id   {'1'}
    body          {'djangoの参考書です。'}
    image_id      {'993f0953c1950c9bc8b382b2ab7998166f16437593d83db745f976e25d98'}
  end

  factory :comment, class: 'Comment' do
    user_id       {'11'}
    book_id       {'8'}
    comment       {'私も読んでみましたが良い参考書だと思いました。'}
  end

  
end