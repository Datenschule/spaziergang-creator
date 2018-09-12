# coding: utf-8
require 'rails_helper'

RSpec.feature 'Make user admin', type: :feature do
  context 'as admin' do
    let!(:admin) { FactoryBot.create(:user, admin: true) }
    let!(:user) { FactoryBot.create(:user) }

    scenario 'from admin dashboard' do
      sign_in admin
      visit '/en/admin/#users'

      expect(page).to have_css('[data-tooltip="Give admin powers"]', count: 1)
      expect(page).to have_css('[data-tooltip="Revoke admin powers"]', count: 1)

      within '#users' do
        find('[data-tooltip="Give admin powers"]:first-of-type').click
      end
      within '#users' do
        expect(page).to have_css('[data-tooltip="Give admin powers"]', count: 0)
        expect(page).to have_css('[data-tooltip="Revoke admin powers"]', count: 2)
      end
    end
  end
end
