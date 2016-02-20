## README

This is following the ActionCable Demo @dhh published: https://www.youtube.com/watch?v=n0WUjGkDFS0

It is using Rails 5 Beta 2.

### Differences to the video tutorial

- using HAML
- using the Postgresql adapter in development instead of async
- Redis dependency removed
- looks a little bit nicer
 
### Additional chat features

- supports multiple user account (fake accounts, no real authentication system built-in)
- supports multiple chat rooms
- provides an overview of all existing rooms
- persists the rooms
- persists the subscription of users to rooms
- pagination / endless scrolling functionality to show older messages

### Bonus features

- emoji support :godmode:
- parses **markdown** and displays it in GitHub style (GFM)
- `code syntax highlighting`
