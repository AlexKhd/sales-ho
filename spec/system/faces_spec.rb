require 'rails_helper'

RSpec.describe 'Faces management', type: :system do
  let(:admin)           { User.first }
  let(:first_name)      { Faker::Name.first_name }
  let(:middle_name)     { Faker::Name.first_name }
  let(:last_name)       { Faker::Name.last_name }
  let(:address)         { Faker::Address.street_address }
  let(:phone)           { Faker::PhoneNumber.phone_number }
  let(:email)           { Faker::Internet.email }
  let(:rating)          { Faker::Number.between(0, 100) }
  let(:description)     { Faker::Lorem.sentence }

  before do
    driven_by(:rack_test)
    visit '/'
    login_as(admin)
  end

  scenario 'work with servers' do
    visit faces_path
    ho_record = Face.find_by_ftype(20)
    dist_record = Face.find_by_ftype(16)

    within "table#faces tr#face-#{ho_record.fid}" do
      expect(page).to have_selector('td.fid', text: '555')
      expect(page).to have_selector('td', text: ho_record.title)
      expect(page).to have_selector('td', text: '555/555')
      expect(page).to have_selector('td', text: '20')
      click_link I18n.t('buttons.edit')
    end
    expect(page).to have_selector('h1', text: I18n.t('forms.edit'))
    expect(page).to have_link 'Cancel'
  end
end
