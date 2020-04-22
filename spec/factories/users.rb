# テストデータの作成
FactoryBot.define do
  factory :user do
    name { Faker::Internet.username(specifier: 5..15) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    gender { 0 }
    birthday { '1990-06-03' }
    height { Faker::Number.within(range: 100..200) }
    goal_weight { Faker::Number.within(range: 30..200) }
    introduction { Faker::Lorem.characters(number:20) }
    is_deleted { false }
    public_status { 0 }
    rank_status { 0 }
    total_point { 0 }
  end
end
