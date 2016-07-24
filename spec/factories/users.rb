FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "sfffffadadaaaadtdt#{n}@example.com" }
    name 'tarou'
    password 'test1234'
  end
end
