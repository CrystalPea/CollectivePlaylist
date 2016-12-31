require 'spec_helper'

RSpec.feature "Inviting others to contribute" do
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

    let(:playlist_1) do {
      title: "Neat Playlist",
      description: "For our awesome party",
      tracks_per_person: 2
    }
    end

  scenario "I want to invite other user to contribute tracks to my playlist" do
    sign_up(user_2)
    log_out
    sign_up(user_1)
    create_playlist(playlist_1)
    click_button("Add contributors")
    expect(current_path).to eq "/invite/new"
    expect(page).to have_content(playlist_1[:title])
    fill_in "existing_users_usernames", with: user_2[:username]
    click_button("Add contributors")
    expect(current_path).to eq "playlists/view"
    message = "#{user_2[:name]} has been added as a contributor to #{playlist_1[:title]}"
    expect(page).to have_content(message)
    expect(Playlist.first.users.count).to eq 2
  end
end