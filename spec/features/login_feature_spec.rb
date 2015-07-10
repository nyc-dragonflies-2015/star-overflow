require 'rails_helper'

describe "the log in process", :type => :feature do
  User.create(username: 'mrpants', email: 'mp3@example.com', password: 'pants')

  it "logs me in" do
    visit login_path
    within ".new_user" do
      fill_in 'user_username', :with => 'mrpants'
      fill_in 'user_password', :with => 'pants'
      click_button 'Log In!'
    end
    visit root_path
    expect(page).to have_link('Logout', href: '/logout')
  end
end