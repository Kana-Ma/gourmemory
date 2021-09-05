require 'rails_helper'

RSpec.describe PointsGenre, type: :model do
  describe 'ジャンルの設定（登録）' do
    before do
      user = FactoryBot.create(:user)
      @point_genre = FactoryBot.build(:points_genre, user_id: user.id)
    end

    context '内容に問題がない場合' do
      it 'genre_name, point1, point2, point3, explanationが正しく入力されていてば登録できること' do
        expect(@point_genre).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'genre_nameが空だと登録できないこと' do
        @point_genre.genre_name = ''
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include("Genre name can't be blank")
      end

      it 'point1が空だと登録できないこと' do
        @point_genre.point1 = ''
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include("Point1 can't be blank")
      end

      it 'point2が空だと登録できないこと' do
        @point_genre.point2 = ''
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include("Point2 can't be blank")
      end

      it 'point3が空だと登録できないこと' do
        @point_genre.point3 = ''
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include("Point3 can't be blank")
      end

      it 'explanationが空だと登録できないこと' do
        @point_genre.explanation = ''
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include("Explanation can't be blank")
      end

      it 'userが紐づいていないと登録できないこと' do
        @point_genre.user_id = nil
        @point_genre.valid?
        expect(@point_genre.errors.full_messages).to include('User must exist')
      end

      it 'user_idとgenre_id(genre_name)の組み合わせが重複する場合は登録できないこと' do
        @point_genre.save
        other_point_genre = FactoryBot.build(:points_genre, user_id: @point_genre.user_id, genre_name: @point_genre.genre_name)
        other_point_genre.valid?
        expect(other_point_genre.errors.full_messages).to include('Genre has already been taken')
      end
    end
  end
end
