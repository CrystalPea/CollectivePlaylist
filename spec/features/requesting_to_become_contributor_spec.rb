require 'spec_helper'

RSpec.feature "Playlist creation" do
  include Helpers

  let(:user_1) do {
    name: "Pea",
    username: "pea",
    email: "pea@gmail.com",
    password: "Mikocian"
    }
  end

  let(:user_2) do {
    name: "Miko",
    username: "omi",
    email: "omi@gmail.com",
    password: "Peacian"
    }
  end

  let(:user_3) do {
    name: "Ollie",
    username: "octollie",
    email: "ollie@puss.ok",
    password: "comeback"
    }
  end

  let(:playlist_1) do {
    title: "Neat Playlist",
    description: "For our awesome party",
    tracks_per_person: 2
  }
  end

  scenario "I want to request to become a contributor" do
    sign_up(user_1)
    create_playlist(playlist_1)
    log_out
    sign_up(user_2)
    visit("/playlists/view")
    expect(Request.all.count).to eq 0
    click_button("I want to contribute")
    expect(Request.all.count).to eq 1
  end
end
