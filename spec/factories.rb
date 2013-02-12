FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "Person #{n}"}
  end
  factory :post do
    sequence(:title) { |n| "This is a new post #{n}" }
    body "lorem ipsum doloar whatever.  This post can go on for a while"
    association :author, factory: :user
  end

  factory :comment do
    body "that post sucked"
    post
    user
  end
end