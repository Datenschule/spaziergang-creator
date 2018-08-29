# coding: utf-8
require 'rails_helper'

RSpec.feature 'Switch languages', type: :feature do
  scenario 'switch from German to English' do
    visit '/de/'
    expect(page).to have_content('Deine Spaziergänge')
    click_link 'EN'
    expect(page).to have_content('Your walks')
  end
  scenario 'switch from English to German' do
    visit '/en/'
    expect(page).to have_content('Your walks')
    click_link 'DE'
    expect(page).to have_content('Deine Spaziergänge')
  end
end
