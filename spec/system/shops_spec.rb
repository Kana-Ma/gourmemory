require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'お店投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    genre = FactoryBot.create(:genre)
    user_genre_relation = FactoryBot.create(:user_genre_relation, user_id: @user.id, genre_id: genre.id)
    point = FactoryBot.create(:point, user_id: @user.id, genre_id: genre.id)
    @shop = FactoryBot.build(:shop, user_id: @user.id, genre_id: genre.id, point_id: point.id)
  end

  context 'お店投稿ができるとき' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('お店を投稿する')
      # 投稿ページに移動する
      visit new_shop_path
      # フォームに情報を入力し、画像を選択する
      select @shop.genre.genre_name, from: 'selected_genre'
      fill_in '店舗名', with: @shop.shop_name
      fill_in '住所', with: @shop.address
      find('#star1').find("img[alt='#{@shop.rate1.floor}']").click
      find('#star2').find("img[alt='#{@shop.rate2.floor}']").click
      find('#star3').find("img[alt='#{@shop.rate3.floor}']").click
      find('#total-star').find("img[alt='#{@shop.total_rate.floor}']").click
      fill_in '評価コメント', with: @shop.text
      attach_file('shop[image]', 'public/images/test_image.png')
      # 送信するとShopモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Shop.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のお店が存在することを確認する（テキスト・画像）
      expect(page).to have_content(@shop.shop_name)
      expect(page).to have_selector('img[src$="test_image.png"]')
    end
  end

  context 'お店投稿ができないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('お店を投稿する')
    end
  end
end

RSpec.describe 'お店編集', type: :system do
  before do
    @shop1 = FactoryBot.create(:shop)
    @shop2 = FactoryBot.create(:shop)
  end

  context 'お店編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したお店の編集ができる' do
      # お店1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @shop1.user.email
      fill_in 'パスワード', with: @shop1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お店1の詳細ページに移動する
      visit shop_path(@shop1.id)
      # 編集ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_shop_path(@shop1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(page).to have_content(@shop1.genre.genre_name)
      expect(
        find('#shop_shop_name').value
      ).to eq(@shop1.shop_name)
      expect(
        find('#shop_address').value
      ).to eq(@shop1.address)
      expect(
        find('#star1').find('#review_star', visible: false).value
      ).to eq("#{@shop1.rate1}")
      expect(
        find('#star2').find('#review_star', visible: false).value
      ).to eq("#{@shop1.rate2}")
      expect(
        find('#star3').find('#review_star', visible: false).value
      ).to eq("#{@shop1.rate3}")
      expect(
        find('#total-star').find('#review_star', visible: false).value
      ).to eq("#{@shop1.total_rate}")
      expect(
        find('#shop_text').value
      ).to eq(@shop1.text)
      # 投稿内容を編集する
      fill_in '店舗名', with: "#{@shop1.shop_name}+編集した店舗名"
      attach_file('shop[image]', 'public/images/test_image2.jpg')
      # 編集してもShopモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Shop.count }.by(0)
      # 詳細ページに遷移したことを確認する
      expect(current_path).to eq(shop_path(@shop1.id))
      # トップページには先ほど変更した内容のツイートが存在することを確認する（テキスト・画像）
      expect(page).to have_content("#{@shop1.shop_name}+編集した店舗名")
      expect(page).to have_selector('img[src$="test_image2.jpg"]')
    end
  end

  context 'お店編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したお店の編集画面には遷移できない' do
      # お店1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @shop1.user.email
      fill_in 'パスワード', with: @shop1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お店2の詳細ページに移動する
      visit shop_path(@shop2.id)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end

    it 'ログインしていないとお店の編集画面には遷移できない' do
      # トップページにいる
      basic_pass root_path
      # お店1の詳細ページに移動する
      visit shop_path(@shop1.id)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
      # お店2の詳細ページに移動する
      visit shop_path(@shop2.id)
      # 編集ボタンがないことを確認する
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe 'お店削除', type: :system do
  before do
    @shop1 = FactoryBot.create(:shop)
    @shop2 = FactoryBot.create(:shop)
  end

  context 'お店削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿したお店の削除ができる' do
      # お店1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @shop1.user.email
      fill_in 'パスワード', with: @shop1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お店1の詳細ページに移動する
      visit shop_path(@shop1.id)
      # 削除ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 削除ボタンをクリックし、アラート表示もOKし、トップページに遷移すると、レコードの数が1減ることを確認する
      click_link '削除'
      expect{
        page.accept_confirm '削除しますか？'
        expect(current_path).to eq root_path
      }.to change { Shop.count }.by(-1)
      # トップページにはお店1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@shop1.shop_name}")
    end
  end

  context 'お店削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したお店の削除ができない' do
      # お店1を投稿したユーザーでログインする
      basic_pass new_user_session_path
      fill_in 'メールアドレス', with: @shop1.user.email
      fill_in 'パスワード', with: @shop1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お店2の詳細ページに移動する
      visit shop_path(@shop2.id)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end

    it 'ログインしていないとお店の削除ボタンがない' do
      # トップページに移動する
      basic_pass root_path
      # お店1の詳細ページに移動する
      visit shop_path(@shop1.id)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('削除')
      # お店2の詳細ページに移動する
      visit shop_path(@shop2.id)
      # 削除ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end
