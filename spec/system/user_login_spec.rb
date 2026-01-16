require 'rails_helper'

RSpec.describe 'User Login', type: :system do
  before do
    #Rails.application.reload_routes!
    driven_by(:rack_test)
  end

  it 'first user and HO record creates automatically' do
    expect(User.all.count).to eq(0)
    expect(Face.all.count).to eq(0)
    visit root_path
    # users
    expect(User.all.count).to eq(1)
    user = User.first
    expect(user.userid).to eq(5550000001)
    expect(user.dist_id).to eq(555)
    expect(user.ownerdist_id).to eq(555)
    # faces
    expect(Face.all.count).to eq(1)
    face_ho = Face.first
    expect(face_ho.fid).to eq(555)
    expect(face_ho.dist_id).to eq(555)
    expect(face_ho.ownerdist_id).to eq(555)
  end

  it 'allows valid user to sign in' do
    visit '/'
    # Create user
    user = User.create!(
      email: 'rspec@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      name: 'RSpec User',
      blocked: false
    )
    user.confirm

    visit root_path
    expect(page).to have_selector('h2', text: 'Sign in to your account')

    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password123'
    click_button 'Sign in'

    expect(page).to have_selector('main h1', text: 'Dashboard')
    expect(page).to have_text('Welcome to Sales-HO Dashboard!')
    expect(page).to have_text('rspec@example.com')
  end
end
