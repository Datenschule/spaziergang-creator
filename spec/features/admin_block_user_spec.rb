# coding: utf-8
require 'rails_helper'

RSpec.feature 'Block a user', type: :feature do
  context 'as admin' do
    let!(:admin) { FactoryBot.create(:user, admin:  true) }
    let!(:user) { FactoryBot.create(:user) }

    scenario 'from admin dashboard', js: true do
      sign_in admin
      visit '/en/admin/'

      expect(page).to_not have_content(I18n.t('user.block'))

      within '#users' do
        find("[data-tooltip='Block user #{user.email}']").click
      end
      within '#users' do
        expect(page).to have_css("[data-tooltip='Unblock user #{user.email}']")
      end
    end
  end

  context 'as blocked user' do
    let!(:admin) { FactoryBot.create(:user, admin:  true) }
    let!(:user) { FactoryBot.create(:user, blocked: true) }
    let!(:walk) {FactoryBot.create(:walk, user: user, public: true)}

    scenario 'I see a blocked notice' do
      sign_in user
      visit root_path
      expect(page).to have_content(I18n.t('user.block_message'))
    end

    scenario 'I get 403 when trying to create a walk' do
      sign_in user
      visit '/en/walks/new?knows_help_site=true'
      fill_in I18n.t('form.name'), with: 'Good walk'
      fill_in I18n.t('form.location'), with: 'Somewhere in Berlin'
      fill_in I18n.t('form.description'), with: 'We will walk around but it does not matter.'
      click_button I18n.t('walk.save')
      expect(page).to have_content("403")
    end

    scenario 'already published walks are hidden' do
      sign_in admin
      visit '/en/walks'
      expect(page).to_not have_content(walk.name)
      visit '/en/admin'
      find("[data-tooltip='Unblock user #{user.email}']").click
      expect(page).to_not have_css("[data-tooltip='Unblock user #{user.email}']")
      visit '/en/walks'
      expect(page).to have_content(walk.name)
    end
  end
end
