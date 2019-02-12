require 'rails_helper'

RSpec.feature 'Order stations and set routes', type: :feature do
  context 'when walk has not enough stations' do
    let(:user) { FactoryBot.create(:user) }
    let(:walk) { FactoryBot.create(:walk, user: user) }
    let!(:station) { FactoryBot.create(:station, user: user, walk: walk) }

    scenario 'can find order button' do
      sign_in_go_to_walk_page
      expect(page).to have_content(station.name)
      expect(page).to have_css('[data-tooltip="Change order"]')
    end

    scenario 'cannot find route button' do
      sign_in_go_to_walk_page
      within '.walk-container' do
        expect(page).to_not have_css('[data-tooltip="Set route"]')
      end
    end
  end

  context 'when walk has enough stations' do
    let(:user) { FactoryBot.create(:user) }
    let(:walk) { FactoryBot.create(:walk, user: user) }
    let!(:stations) { FactoryBot.create_list(:station, 2, user: user, walk: walk) }

    scenario 'can find and click order button' do
      sign_in_go_to_walk_page
      expect(page).to have_css('[data-tooltip="Change order"]', count: 1)
      find('[data-tooltip="Change order"]').click
      expect(page).to have_content I18n.t('station.change_order')
    end

    scenario 'can find route button and click it, also courseline' do
      sign_in_go_to_walk_page
      expect(page).to have_content(I18n.t('walk.form.help.courseline'))
      expect(page).to have_css('[data-tooltip="Set route"]')
      click_route_btn_get_redirected_to_order
      expect(page).to have_content I18n.t('walk.course.title')
      within '.breadcrumb' do
        click_link walk.name
      end
      expect(page).to_not have_content(I18n.t('walk.form.help.courseline'))
    end
  end

  def sign_in_go_to_walk_page
    sign_in user
    visit "/en/walks/#{walk.id}"
  end

  def click_route_btn_get_redirected_to_order
    within '.walk-container' do
      find('[data-tooltip="Set route"]').click
    end
    expect(page).to have_content I18n.t('walk.notice.force_sort')
    expect(page).to have_content I18n.t('walk.course.title')
    click_button I18n.t('station.save_order')
    # faking the ajax request
    walk.courseline = '[[213423, 1234], [123423, 234123]]'
    walk.save!
    find('[data-tooltip="Set route"]').click
  end
end
