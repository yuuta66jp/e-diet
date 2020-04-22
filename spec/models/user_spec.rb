require 'rails_helper'

describe 'Userモデルのテスト', type: :model do
  describe 'バリデーションテスト' do
    let(:user) { FactoryBot.build(:user) }
    # subject(テスト対象をまとめる（expectの引数になるもの))
    subject { test_user.valid? }

    context 'nameカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false;
      end
      it '15文字以下であること' do
        test_user.name = Faker::Lorem.characters(number:16)
        is_expected.to eq false;
      end
    end

    context 'genderカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.gender = ''
        is_expected.to eq false;
      end
    end

    context 'birthdayカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.birthday = ''
        is_expected.to eq false;
      end
    end

    context 'goal_weightカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.goal_weight = ''
        is_expected.to eq false;
      end
      it '数値であること' do
        test_user.goal_weight = Faker::Lorem.word
        is_expected.to eq false;
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }
      it '50文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number:51)
        is_expected.to eq false;
      end
    end

    context 'total_pointカラム' do
      let(:test_user) { user }
      it '空欄でないこと' do
        test_user.total_point = ''
        is_expected.to eq false;
      end
      it '整数であること' do
        # 小数点を指定
        test_user.total_point = Faker::Number.decimal(l_digits: 1)
        is_expected.to eq false;
      end
    end

  end
  
end

