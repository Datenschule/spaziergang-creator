require 'rails_helper'

RSpec.feature 'Create new station', type: :feature do
  context 'when user is signed in and walk exists' do
    user = FactoryBot.create(:user)
    let!(:walk) { FactoryBot.create(:walk, user: user)}

    it 'user can add new station' do
      sign_in user
      visit root_path
      go_to_existing_walk
      go_to_new_station_form
      fill_in_station_form
      have_new_station
    end
  end

  def go_to_existing_walk
    click_link I18n.t('walk.own')
    expect(page).to have_content walk.name
    click_link walk.name
    expect(page).to have_content(I18n.t('station.none'))
  end

  def go_to_new_station_form
    click_link I18n.t('station.new_verb')
    expect(page).to have_content(I18n.t('station.new'))
  end

  def fill_in_station_form
    fill_in I18n.t('form.name'), with: 'Station Alpha'
    fill_in I18n.t('form.description'), with: 'Something on why this is so cool'
    find('.marker.mapboxgl-marker').drag_to find('.mapboxgl-ctrl-geocoder.mapboxgl-ctrl input')
    click_button I18n.t('station.save')
  end

  def have_new_station
    expect(page).to have_content('Station Alpha')
    expect(page).to have_content(I18n.t('subject.none'))
  end
end
