# coding: utf-8
require 'rails_helper'

RSpec.feature 'Delete another user', type: :feature do
  context 'as admin' do
    let!(:admin) { FactoryBot.create(:user, admin:  true) }
    let!(:user) { FactoryBot.create(:user) }

    scenario 'from admin dashboard', js: true do
      sign_in admin
      visit '/en/admin/'

      expect(page).to have_content(user.email)

      within '#users' do
        accept_confirm do
          find("[data-tooltip='Delete user #{user.email}']").click
        end
      end
      within '#users' do
        expect(page).to_not have_content(user.email)
      end
    end
  end
end
