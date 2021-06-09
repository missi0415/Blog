FactoryBot.define do

  factory :book, class: 'Book' do
    user_id       {'1'}
    title         { Faker::Book.title }
    author        { Faker::Book.author }
    category_id   {'1'}
    body          {'djangoの参考書です。'}
    image_id      {'993f0953c1950c9bc8b382b2ab7998166f16437593d83db745f976e25d98'}
  end

end