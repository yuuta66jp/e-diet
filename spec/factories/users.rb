# テストデータの作成
FactoryBot.define do
  factory :user do
    name { 'テストユーザー' }
    email { 'test1@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
    gender { 0 }
    birthday { '1990-06-03' }
    height { 165 }
    goal_weight { 60 }
    introduction { 'test1test1test1' }
    is_deleted { false }
    public_status { 0 }
    rank_status { 0 }
    total_point { 0 }
  end
end
