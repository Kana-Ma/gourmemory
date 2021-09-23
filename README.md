# アプリケーション名
gourmemory（グルメモリー）

# アプリケーション概要
飲食店のクチコミを投稿・閲覧することができるアプリケーションを作成しました。
ユーザー登録の有無に関わらず、投稿されたクチコミを閲覧・検索することができます。
また、ユーザー登録をすることで、クチコミの投稿・編集・削除、コメントの投稿をすることができます。

# 本番環境

https://gourmemory.work/

### Basic認証
- ID: lucky
- Pass: 7777

### テスト用アカウント
- メールアドレス： test1@test.com
- パスワード： 0a0a0a

# 制作背景（意図）
食べ歩きや飲食店の新規開拓を趣味とする人のためのアプリケーションです。

一般的なクチコミアプリとの違いは、投稿者は、その人の好みや重視したいポイントを予め設定し、設定した項目について、お店の感想（評価）を投稿することができます。

これにより、投稿者の嗜好がわかりやすくなるので、自分と同じような嗜好の人の感想（評価）を参考にすることができます。

また、同じような嗜好の人が交流するきっかけになればと思い、コメント機能を実装しました。

# 各機能について（利用方法等）

### トップページ

[![Image from Gyazo](https://i.gyazo.com/5bf2a754865bfb57a4cf1b6ab187bcda.jpg)](https://gyazo.com/5bf2a754865bfb57a4cf1b6ab187bcda)

### ユーザー登録

[![Image from Gyazo](https://i.gyazo.com/a98b5c26afa50e176b795cbb2b88f467.gif)](https://gyazo.com/a98b5c26afa50e176b795cbb2b88f467)

1. トップページの新規登録ボタンを押します。
1. ニックネーム等の必要事項を入力し、登録ボタンを押します。

### ジャンルの設定

[![Image from Gyazo](https://i.gyazo.com/7f0f6dce86d15fe0ced1941eebc73ecd.gif)](https://gyazo.com/7f0f6dce86d15fe0ced1941eebc73ecd)

- お店を投稿する前に、ジャンルを設定する必要があります。

1. トップページの「ジャンルを設定する」ボタンを押します。（お店投稿ページにも、ジャンル設定ページへのリンクを設けています。）
1. ジャンルやPoint等を入力し、設定ボタンを押します。

```
ジャンル欄にはインクリメンタルサーチを実装し、すでに他のユーザーが設定済みのジャンル名が表示されるようにしました。
```

### お店の投稿

[![Image from Gyazo](https://i.gyazo.com/ca14135ecadf21a6525d2f345559aeaf.gif)](https://gyazo.com/ca14135ecadf21a6525d2f345559aeaf)

1. トップページの「お店を投稿する」ボタンを押します。
1. 店舗名等を入力し、投稿ボタンを押します。

```
ジャンル選択のプルダウンには、ログインしているユーザーが設定したジャンルのみが表示されます。
また、ジャンルを選択すると、Point1〜3が、ユーザーが設定した項目に切り替わります。
```

### お店一覧

[![Image from Gyazo](https://i.gyazo.com/e0a410b3f3b3cf96e51618da8def926b.jpg)](https://gyazo.com/e0a410b3f3b3cf96e51618da8def926b)

- トップページ下部に投稿の一覧が表示されます。

### お店詳細

[![Image from Gyazo](https://i.gyazo.com/cd42332b95910fd531dc291cd1038958.gif)](https://gyazo.com/cd42332b95910fd531dc291cd1038958)

- お店の一覧より、各投稿の画像または店舗名をクリックすると、詳細ページに遷移します。
- 投稿された内容のほかに、マップとコメント欄が表示されます。

### お店の編集・削除

[![Image from Gyazo](https://i.gyazo.com/0588c66d4c86fbfc8b29fa58126c80b4.jpg)](https://gyazo.com/0588c66d4c86fbfc8b29fa58126c80b4)

- 投稿したユーザーに限り、詳細ページで編集・削除ボタンが表示されます。

### ユーザー詳細

[![Image from Gyazo](https://i.gyazo.com/dc2737f0b6ea267b753efd8545c379c2.gif)](https://gyazo.com/dc2737f0b6ea267b753efd8545c379c2)

- お店一覧のユーザー名のリンクや、詳細ページ下部に設置されたリンクから、ユーザーごとのページに遷移することができます。
- ユーザーのプロフィールと、ジャンルごとに分けられたお店一覧が表示されます。

### お店の検索

[![Image from Gyazo](https://i.gyazo.com/7616d9b5e06ba423a47e95add977065e.jpg)](https://gyazo.com/7616d9b5e06ba423a47e95add977065e)

- ジャンルや店名で検索することができます。

# 使用技術（開発環境）

### バックエンド
Ruby, Ruby on Rails

### フロントエンド
JavaScript, jQuery, Ajax

### データベース
MySQL, MariaDB（本番環境）

### インフラ
AWS(EC2, S3, Route 53, Certificate Manager)
Capistrano

### Webサーバー（本番環境）
Nginx

### アプリケーションサーバー（本番環境）
Unicorn

### ソース管理
GitHub, GitHub Desktop

### テスト
RSpec

### エディタ
Visual Studio Code

# DB設計
[![Image from Gyazo](https://i.gyazo.com/e920e2a436137b171fc0a882a1312fea.png)](https://gyazo.com/e920e2a436137b171fc0a882a1312fea)

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false, unique: true |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| prefecture_id      | integer | null: false               |
| introduction       | text    |                           |

### Association

- has_many :user_genre_relations
- has_many :genres, through: :user_genre_relations
- has_many :points
- has_many :shops
- has_many :comments

## genres テーブル

| Column     | Type   | Options                       |
| ---------- | ------ | ----------------------------- |
| genre_name | string | null: false, uniqueness: true |

### Association

- has_many :user_genre_relations
- has_many :users, through: :user_genre_relations
- has_many :points
- has_many :shops

## user_genre_relations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| genre  | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :genre

## points テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| point1      | string     | null: false                    |
| point2      | string     | null: false                    |
| point3      | string     | null: false                    |
| explanation | text       | null: false                    |
| user        | references | null: false, foreign_key: true |
| genre       | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :genre
- has_many :shops

## shops テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| shop_name  | string     | null: false                    |
| address    | string     | null: false                    |
| total_rate | float      | null: false, default: 0        |
| rate1      | float      | null: false, default: 0        |
| rate2      | float      | null: false, default: 0        |
| rate3      | float      | null: false, default: 0        |
| text       | text       | null: false                    |
| user       | references | null: false, foreign_key: true |
| genre      | references | null: false, foreign_key: true |
| point      | references | null: false, foreign_key: true |
| latitude   | float      |                                |
| longitude  | float      |                                |

### Association

- belongs_to :user
- belongs_to :genre
- belongs_to :point
- has_many :comments

## comments テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| comment | text       | null: false                    |
| user    | references | null: false, foreign_key: true |
| shop    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :shop

# 今後の課題
- リファクタリングを行い、コードの可読性を高めたいと思います。
