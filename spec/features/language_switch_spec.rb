# coding: utf-8
require 'rails_helper'

RSpec.feature 'Switch languages', type: :feature do
  scenario 'switch from German to English' do
    visit '/de/'
    expect(page).to have_content('Alle Spaziergänge')
    click_link 'EN'
    expect(page).to have_content('All walks')
  end
  scenario 'switch from English to German' do
    visit '/en/'
    expect(page).to have_content('All walks')
    click_link 'DE'
    expect(page).to have_content('Alle Spaziergänge')
  end
end
