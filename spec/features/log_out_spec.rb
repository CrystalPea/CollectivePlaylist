require 'spec_helper'

RSpec.feature "Log out" do

  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I should be able to log out" do
    sign_up(user_1)
    click_link("Log out")
    expect(current_path).to eq "/"
    expect(page).to have_content "Goodbye, we hope to see you again!"
  end
end
