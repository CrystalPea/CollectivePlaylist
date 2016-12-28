require 'spec_helper'

RSpec.feature "Playlist creation" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "peaczek@gmail.com",
    password: "Mikocian"
    }
  end

  scenario "I want to create a playlist" do
    sign_up(user_1)
    visit '/playlists/new'
    
  end
end
