# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :system do
  describe 'view' do
    context 'when not authorized' do
      before { visit root_path }

      it 'shows the login button' do
        expect(page).to have_link 'Войти', href: '/users/sign_in?locale=ru'
      end
    end

    # context 'when authorized', js_visual: true do
    context 'when authorized' do
      login_user
      before { visit root_path }

      it 'shows the logout button' do
        expect(page).to have_button 'Выход'
      end
    end
  end
end
