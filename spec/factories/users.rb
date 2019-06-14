FactoryBot.define do
  factory :user do
    name { 'Foo Bar' }
    email { 'foo@email.com' }
    confirmed_at { Time.current }
  end
end
