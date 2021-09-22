require 'rails_helper'

def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'コメント投稿', type: :system do
  before do
    @shop = FactoryBot.create(:shop)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはお店詳細ページでコメント投稿できる' do
    # ログインする
    basic_pass new_user_session_path
    fill_in 'メールアドレス', with: @shop.user.email
    fill_in 'パスワード', with: @shop.user.password
    find('input[name="commit"]').click
    expect(current_path).to eq(root_path)
    # お店詳細ページに遷移する
    visit shop_path(@shop.id)
    # フォームにコメントを入力する
    fill_in 'comment_comment', with: @comment
    # コメントを送信すると、Commentモデルのカウントが1上がることを確認する
    expect {
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクトされることを確認する
    expect(current_path).to eq(shop_path(@shop.id))
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content(@comment)
  end

  # ログインしていない場合は、お店詳細ページでテスト済み
end
