# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :controller do
  let!(:game) { create(:game) }

  describe 'GET #index' do
    context 'with HTML format' do
      before do
        get :index
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'renders the index template' do
        expect(response).to render_template(:index)
      end

      it 'assigns @games' do
        expect(assigns(:games)).to include(game)
      end
    end

    context 'with JSON format' do
      before do
        get :index, format: :json
      end

      it 'returns a successful response' do
        expect(response).to be_successful
      end

      it 'returns games in JSON format' do
        json_response = JSON.parse(response.body)
        expect(json_response).not_to be_empty
      end
    end
  end

  describe 'GET #show' do
    let!(:viewed) { 2 }

    before do
      session[:history] = []
      get :show, params: { id: game.id }
    end

    it 'returns a successful response' do
      expect(response).to be_successful
    end

    it 'assigns @game' do
      expect(assigns(:game)).to eq(game)
    end

    it 'stores the game id in session history' do
      expect(session[:history]).to include(game.id)
    end

    it "limits session history to viewed entries" do
      create(:game)
      Game.pluck(:id).each { |id| get :show, params: { id: id } }
      expect(session[:history].size).to eq(viewed)
    end
  end
end
