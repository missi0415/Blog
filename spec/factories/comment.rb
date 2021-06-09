FactoryBot.define do

  factory :comment, class: 'Comment' do
    user_id {'1'}
    book_id {'1'}
    comment {'私も読んでみましたが良い参考書だと思いました。'}
  end

end