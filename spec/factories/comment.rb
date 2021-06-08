FactoryBot.define do

  factory :comment, class: 'Comment' do
    user_id {'11'}
    book_id {'8'}
    comment {'私も読んでみましたが良い参考書だと思いました。'}
  end

end