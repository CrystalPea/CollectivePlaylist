## Collective Playlist ##

Collective Playlist is a web app I made for creating playlists together with friends. It allows you to create a playlist and invite other users to contribute tracks to it.  

The idea came to me during the graduation of our seniors at Makers Academy. There was no music during social part of the event and I thought... it would be nice to have music on our graduation. But how to guarantee that everyone would be happy with the choice of music? Here enters Collective Playlist :smile:.  

I developed the MVP over Christmas break.  

####Features:####
* sign up  
* log in  
* log out  
* creating playlists  
* adding contributors to playlists  
* adding tracks to playlists  
* viewing all playlists with their contributors and tracks  
* viewing own playlists

####Areas for further development:####
* deleting tracks  
* being able to set a playlist to public or private  
* sending invites for friends to join and contribute  
* email confirmations  
* integration with Spotify  
* "friend" system  
* "everyone can contribute" option  
* auto-complete for usernames when adding contributors  
* auto-complete for tracks after Spotify integration  

### How to run: ###
Either go to [Collective Playlist on Heroku](https://collective-playlist.herokuapp.com/) or  
1. fork and clone this repo to your local machine  
2. go to project repo in your terminal  
3. create databases for the project  
```
collective_playlist_test  
collective_playlist_development  
```
4. run bundle install  
5. enter the following in your terminal:  
```
ruby app/app.rb  
```
6. Enter this address in your browser:  
```
http://localhost:4567/  
```

Well done! Collective Playlist should be up and running! :)  

If you encounter any issues please raise them here on Github so that I can improve my app, thnak you!  
