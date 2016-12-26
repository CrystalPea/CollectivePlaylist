require 'spec_helper'

RSpec.feature "Log in" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I would like to log in" do
    sign_up(user_1)
    click_link("Log out")
    click_link("Log in")
    expect(current_path).to eq "/sessions/new"
    fill_in "username", with: "pea"
    fill_in "password", with: "Mikocian"
    click_button "Log in"
    expect(current_path).to eq "/dashboard"
    message = "Welcome to Collective Playlist, Pea!"
    expect(page).to have_content(message)
  end

end
