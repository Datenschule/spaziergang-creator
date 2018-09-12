# coding: utf-8
require 'rails_helper'

RSpec.feature 'Publish a walk from list view', type: :feature do
  context 'with a publishable walk ready' do
    let!(:user) { create(:user, username: 'foobi') }
    let(:walk) { create(:walk,
                        user: user,
                        courseline: [[12, 12], [12.1, 12]]) }
    let(:stations) { create_list(:station, 2,
                                 user: user,
                                 walk_id: walk.id,
                                 next: 1) }
    let(:subject) { create(:subject, user: user,
                           station_id: stations.first.id) }
    let!(:page) { create(:page, user: user,
                         subject_id: subject.id) }

    pending 'click on publish button', js: true do
      sign_in user
      visit '/en/walks'
      expect(page).to have_content walk.name

      within '.walk-list' do
        find('[data-tooltip="Publish walk"]').click
      end
      expect(page).to_not have_selector '[data-tooltip="Publish walk"]'
    end
  end
end
