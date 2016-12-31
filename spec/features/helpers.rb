module Helpers

  def sign_up(user)
    visit "/"
    click_link("Sign up")
    fill_in "name", with: user[:name]
    fill_in "username", with: user[:username]
    fill_in "email", with: user[:email]
    fill_in "password", with: user[:password]
    fill_in "password_confirmation", with: user[:password]
    click_button "Sign up"
  end

  def create_playlist(playlist)
    visit "/playlists/new"
    fill_in 'title', with: playlist[:title]
    fill_in 'description', with: playlist[:description]
    select playlist[:tracks_per_person], from: 'tracks_per_person'
    click_button "Create Playlist"
  end

  def add_track(track)
    click_button "Add track(s)"
    fill_in "artist", with: track[:artist]
    fill_in "title", with: track[:title]
    click_button "Add track(s)"
  end

  def log_out
    click_link("Log out")
  end

end
