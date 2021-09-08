require 'rails_helper'

RSpec.describe Shop, type: :model do
  before do
    user = FactoryBot.create(:user)
    genre = FactoryBot.create(:genre)
    point = FactoryBot.create(:point, user_id: user.id, genre_id: genre.id)
    @shop = FactoryBot.build(:shop, user_id: user.id, genre_id: genre.id, point_id: point.id)
  end

  describe '店舗新規投稿' do
    context '新規投稿できる場合' do
      it 'shop_name, address, total_rate, rate1, rate2, rate3, text, imageが存在し、user, genre, pointと紐づいていれば投稿できる' do
        expect(@shop).to be_valid
      end

      it 'imageが空でも投稿できる' do
        @shop.image = nil
        expect(@shop).to be_valid
      end
    end

    context '新規投稿できない場合' do
      it 'shop_nameが空では投稿できない' do
        @shop.shop_name = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Shop name can't be blank")
      end

      it 'addressが空では投稿できない' do
        @shop.address = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Address can't be blank")
      end

      it 'total_rateが空では投稿できない' do
        @shop.total_rate = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Total rate can't be blank")
      end

      it 'total_rateが半角数字以外では投稿できない' do
        @shop.total_rate = '３'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Total rate is not a number')
      end

      it 'total_rateが0では投稿できない' do
        @shop.total_rate = '0'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Total rate must be greater than or equal to 0.5')
      end

      it 'total_rateが5より大きいと投稿できない' do
        @shop.total_rate = '6'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Total rate must be less than or equal to 5')
      end

      it 'rate1が空では投稿できない' do
        @shop.rate1 = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Rate1 can't be blank")
      end

      it 'rate1が半角数字以外では投稿できない' do
        @shop.rate1 = '３'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate1 is not a number')
      end

      it 'rate1が0では投稿できない' do
        @shop.rate1 = '0'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate1 must be greater than or equal to 0.5')
      end

      it 'rate1が5より大きいと投稿できない' do
        @shop.rate1 = '6'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate1 must be less than or equal to 5')
      end

      it 'rate2が空では投稿できない' do
        @shop.rate2 = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Rate2 can't be blank")
      end

      it 'rate2が半角数字以外では投稿できない' do
        @shop.rate2 = '３'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate2 is not a number')
      end

      it 'rate2が0では投稿できない' do
        @shop.rate2 = '0'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate2 must be greater than or equal to 0.5')
      end

      it 'rate2が5より大きいと投稿できない' do
        @shop.rate2 = '6'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate2 must be less than or equal to 5')
      end

      it 'rate3が空では投稿できない' do
        @shop.rate3 = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Rate3 can't be blank")
      end

      it 'rate3が半角数字以外では投稿できない' do
        @shop.rate3 = '３'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate3 is not a number')
      end

      it 'rate3が0では投稿できない' do
        @shop.rate3 = '0'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate3 must be greater than or equal to 0.5')
      end

      it 'rate3が5より大きいと投稿できない' do
        @shop.rate3 = '6'
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Rate3 must be less than or equal to 5')
      end

      it 'textが空では投稿できない' do
        @shop.text = ''
        @shop.valid?
        expect(@shop.errors.full_messages).to include("Text can't be blank")
      end

      it 'userが紐付いていないと投稿できない' do
        @shop.user = nil
        @shop.valid?
        expect(@shop.errors.full_messages).to include('User must exist')
      end

      it 'genreが紐付いていないと投稿できない' do
        @shop.genre = nil
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Genre must exist')
      end

      it 'pointが紐付いていないと投稿できない' do
        @shop.point = nil
        @shop.valid?
        expect(@shop.errors.full_messages).to include('Point must exist')
      end
    end
  end
end
