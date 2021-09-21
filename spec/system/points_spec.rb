require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'ジャンル・ポイント設定（投稿）', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @points_genre = FactoryBot.build(:points_genre, user_id: @user.id)
  end

  context 'ジャンル・ポイント設定ができるとき' do
    it 'ログインしたユーザーは新規設定できる' do
      # ログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ジャンル設定ページへのボタンがあることを確認する
      expect(page).to have_content('ジャンルを設定する')
      # 設定ページに移動する
      visit new_point_path
      # フォームに情報を入力する
      fill_in 'ジャンル', with: @points_genre.genre_name
      fill_in 'Point1', with: @points_genre.point1
      fill_in 'Point2', with: @points_genre.point2
      fill_in 'Point3', with: @points_genre.point3
      fill_in 'points_genre_explanation', with: @points_genre.explanation
      # 送信するとPointモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change { Point.count }.by(1)
      # お店投稿ページに遷移することを確認する
      expect(current_path).to eq(new_shop_path)
      # マイページへのボタンがあることを確認する
      expect(page).to have_content('マイページ')
      # マイページに移動する
      visit user_path(@user.id)
      # マイページに先ほど設定した内容のジャンル・ポイントが存在することを確認する
      expect(page).to have_content(@points_genre.genre_name)
      expect(page).to have_content(@points_genre.point1)
      expect(page).to have_content(@points_genre.point2)
      expect(page).to have_content(@points_genre.point3)
      expect(page).to have_content(@points_genre.explanation)
    end
  end

  context 'ジャンル・ポイント設定ができないとき' do
    it 'ログインしていないとジャンル・ポイント設定ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # ジャンル設定ページへのボタンがないことを確認する
      expect(page).to have_no_content('ジャンルを設定する')
    end
  end
end
