require 'spec_helper'

RSpec.feature "Sign up as admin" do
  scenario "user signs up" do
    user_count = User.all.count
    visit("/users/new")
    fill_in "name", with: "Pea"
    fill_in "username", with: "pea"
    fill_in "email", with: "peaczek@gmail.com"
    fill_in "password", with: "Mikocian86"
    click_button "Sign up"

    expect(current_path).to eq "/dashboard"
    expect(page).to have_content "Welcome to Collective Playlist, #{User.first.name}!"
    expect(User.all.count).to eq(user_count + 1)
  end

  scenario "user uses incorrect email format" do
  end

  scenario "user uses taken username" do
  end

  scenario "user uses taken email" do
  end

  scenario "password confirmation does not match password" do
  end

  scenario "user uses forbidden special characters" do
  end
end
