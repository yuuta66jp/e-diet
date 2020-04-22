require 'rails_helper'
# describe(テスト対象),type:[Specの種類]
describe 'ユーザー機能', type: :system do
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
        # fill_inメソッド(フォームフィールドを探し、withで入力)
        fill_in 'user[name]', with: 'ユーザーa'
        fill_in 'user[password]', with: 'password'
        # click_bottonメッソドでログインを押す
        click_button 'ログイン'
      end

      it 'ログインに成功する' do
        expect(page).to have_content 'ユーザーa'
      end
    end
  end
end