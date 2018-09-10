require 'rails_helper'

RSpec.feature 'Login', type: :feature do
  let!(:user) { create(:user, username: 'test', email: 'test@test.de', password: '1234567890abcde')}
  scenario 'with email' do
    visit root_path
    within '.navbar' do
      click_link I18n.t('signin.label')
    end
    fill_in 'Login', with: 'test@test.de'
    fill_in 'Password', with: '1234567890abcde'
    click_button 'Sign in'
    expect(page).to have_content("Ahoi, test@test.de!")
  end

  scenario 'with username' do
    visit root_path
    within '.navbar' do
      click_link I18n.t('signin.label')
    end
    fill_in 'Login', with: 'test'
    fill_in 'Password', with: '1234567890abcde'
    click_button 'Sign in'
    expect(page).to have_content("Ahoi, test@test.de!")
  end
end
