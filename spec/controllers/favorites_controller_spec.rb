require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  let(:user) { create(:user) }
  let(:game) { create(:game) }
  let(:other_game) { create(:game) }

  describe 'GET #index' do
    context 'when user is signed in' do
      before do
        sign_in user
        user.favorites.create(game: game)
        get :index
      end

      it 'assigns @favorites' do
        expect(assigns(:favorites)).to include(game)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end

    context 'when user is not signed in' do
      before do
        session[:favorites] = [game.id]
        get :index
      end

      it 'assigns @favorites' do
        expect(assigns(:favorites)).to include(game)
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end
    end
  end
end
