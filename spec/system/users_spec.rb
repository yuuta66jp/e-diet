require 'rails_helper'
# describe(テスト対象),type:[Specの種類]
describe 'ユーザー認証のテスト', type: :system do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録したとき' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: Faker::Lorem.characters(number:10)
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
describe 'ユーザー関連のテスト' do
  let(:user) { FactoryBot.create(:user) }
  # let!によって各テストのブロック実行前に作成される
  let!(:test_user2) { FactoryBot.create(:user) }
  let!(:diary) { FactoryBot.create(:diary, user: user) }
  before do
    visit new_user_session_path
    fill_in 'user[name]', with: user.name
    fill_in 'user[password]', with: user.password
    click_button 'ログイン' 
  end

  describe '一覧画面のテスト' do
    before do
      visit users_path
    end
    context '表示の確認' do
      it '自分と他の人の画像が表示される' do
        # img要素を検索し全件取得
        expect(all('img').size).to eq(2)
      end
      it '自分と他の人の名前が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content test_user2.name
      end
      it 'ユーザー詳細リンクが表示される' do
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_link test_user2.name, href: user_path(test_user2)
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'ユーザー名が表示される' do
        expect(page).to have_content(user.name)
      end
      it '投稿日記一覧へのリンク先が正しい' do
        expect(page).to have_link user.diaries.count, href: '/diaries?id=' + user.id.to_s + '&index=user'
      end
      it '編集画面へのリンク先が正しい' do
        expect(page).to have_link 'プロフィール編集', href: edit_user_path(user)
      end
      it '退会確認画面へのリンク先が正しい' do
        expect(page).to have_link '退会する', href: congfirm_path
      end
    end
  end

  describe '編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他の人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(test_user2)
        expect(current_path).to eq('/users/' + test_user2.id.to_s)
      end
    end
    context '表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it '会員情報編集画面と表示される' do
        expect(page).to have_content('会員情報編集画面')
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '編集に成功する' do
        click_button '変更を保存する'
        expect(page).to have_content '更新が成功しました！'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '変更を保存する'
        # to_notで表示されていないことを検証
        expect(page).to_not have_content '更新が成功しました！'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end
  end

  describe '退会のテスト' do
    context '退会処理を行ったとき' do
      it '退会に成功する' do
        visit congfirm_path
        # click_button '退会する'
        # click_buttonが作動しないためbtn classを指定して作動
        page.first(".btn-danger").click
        expect(page).to have_content '退会が完了しました'
        expect(current_path).to eq(root_path)
      end
    end
  end

end
