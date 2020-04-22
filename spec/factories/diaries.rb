# テストデータの作成
FactoryBot.define do
  factory :diary do
    remark { Faker::Lorem.characters(number:20) }
    activity_status { 0 }
    created_on { '2020-04-22' }
    user
  end
end
