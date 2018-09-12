require 'rails_helper'

RSpec.feature 'Create new walk', type: :feature do
  context 'with without prior walks' do
    before {
      user = FactoryBot.create(:user)
      sign_in user
    }
    scenario 'user creates new walk' do
      visit root_path
      go_to_new_walk
      be_redirected_to_help_page
      fill_in_walk_form
      have_new_walk
    end
  end

  context 'with prior walks' do
    before {
      user = FactoryBot.create(:user)
      sign_in user
      FactoryBot.create(:walk, user: user)
    }
    scenario 'user creates new walk' do
      visit root_path
      go_to_new_walk
      fill_in_walk_form
      have_new_walk
    end
  end

  def go_to_new_walk
    click_link I18n.t('walk.own')
    within '.walk-header' do
      find_link(class: ['btn', 'tooltip']).click
    end
  end

  def be_redirected_to_help_page
    expect(page).to have_content('Was ist ein Datenspaziergang')
    click_link 'Ersten Spaziergang anlegen'
  end

  def fill_in_walk_form
    expect(page).to have_content(I18n.t('walk.new_verb'))
    fill_in I18n.t('form.name'), with: 'Good walk'
    fill_in I18n.t('form.location'), with: 'Somewhere in Berlin'
    fill_in I18n.t('form.description'), with: 'We will walk around but it does not matter.'
    click_button I18n.t('walk.save')
  end

  def have_new_walk
    expect(page).to have_content('Good walk')
    expect(page).to have_content I18n.t('walk.save_success')
  end
end
