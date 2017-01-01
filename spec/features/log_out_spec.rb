require 'spec_helper'

RSpec.feature "Log out" do

  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "pea@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I should be able to log out" do
    sign_up(user_1)
    log_out
    expect(current_path).to eq "/"
    expect(page).to have_content "Goodbye, we hope to see you again!"
  end

  scenario "I should only see log out button when I'm logged in" do
    visit '/'
    expect(page).not_to have_content "Log out"
  end
end
