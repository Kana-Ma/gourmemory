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
| comment | string     | null: false                    |
| user    | references | null: false, foreign_key: true |
| shop    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :shop
