require 'rails_helper'
# describe(テスト対象),type:[Specの種類]
describe 'ユーザー承認のテスト', type: :system do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録したとき' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Internet.username(specifier: 5)
        select '男性', from: 'user[gender]'
        select 1991, from: 'user[birthday(1i)]'
        select 6, from: 'user[birthday(2i)]'
        select 4, from: 'user[birthday(3i)]'
        fill_in 'user[height]', with: Faker::Number.within(range: 100..200)
        fill_in 'user[goal_weight]', with: Faker::Number.within(range: 30..200)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'

        click_button '新規登録'
        expect(page).to have_content '新規登録が完了しました'
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        select '選択してください', from: 'user[gender]'
        select '--', from: 'user[birthday(1i)]'
        select '--', from: 'user[birthday(2i)]'
        select '--', from: 'user[birthday(3i)]'
        fill_in 'user[height]', with: ''
        fill_in 'user[goal_weight]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''

        click_button '新規登録'
        expect(page).to have_content 'エラー'        
      end
    end
  end
  describe 'ログイン機能' do
    # before(事前準備)
    before do
      # user_aの作成(nameの指定)
      user_a = FactoryBot.create(:user, name: 'ユーザーa')
    end
    # contxt(テスト内容の分類)
    context 'ユーザーAがログインしたとき' do
      before do
        # visit[URL]で特定のURLにアクセス
        visit new_user_session_path
      end
      it 'ログインに成功する' do
        # fill_inメソッド(フォームフィールドを探し、withで入力)
        fill_in 'user[name]', with: 'ユーザーa'
        fill_in 'user[password]', with: 'password'
        # click_buttonメッソドでログインを押す
        click_button 'ログイン'

        expect(page).to have_content 'ユーザーa'
      end
      it 'ログインに失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end