# Turbo Chatroom + Turbo Chatroom Admin companion app
## Turbo Chatroom app 
### Changes
- Added debugging gems (awesome_print, pry)
- Fixed seeds.rb (missing required username attribute on User model)
- Added gems: sidekiq, sidekiq-scheduler
- Added `app/workers/update_message_event_worker.rb` Worker. This worker is fired periodically 
using sidekiq-scheduler. Worker handles incoming events coming from Turbo Chatroom Admin app via Redis Streams, 
then - it updates frontend (removes message from the UI using broadcast/Turbo Streams). 
- Dockerized application to be able to easily run multiple services at once

## Turbo Chatroom Admin app
### Changes
- Created new Rails application and added some basic tools (pry, sidekiq, sidekiq-scheduler, tailwindcss)
- Created messages controller with *messages being sent* functionality
- Created messages list - we can see last messages, new ones comming from Turbo Chatroom app are being added
to the end of the list. *It* was achieved using broadcast/Turbo Streams.
- Receiving new messages from the Turbo Chatroom app was achieved using Redis Streams + sidekiq + sidekiq-scheduler. 
Main file to this is located here: `app/workers/receive_messages_event_worker.rb`.
- Added ability/button to hide messages - it will gray out and strikethrough hidden message on the list.
- Notification/event about hiding message is propagated through Redis Streams (from `MessagesController`)
to Turbo Chatroom app.
- Added devise gem. Added form/ability to login/logout to the application. Admin role is checked before logging in
(`app/controllers/users/sessions_controller.rb`).
- Dockerized application to be able to easily run multiple services at once

## How to run both applications
- `docker-compose build`
- `docker-compose up`

### How to use *Rails Console*
- `docker-compose exec turbo_chatroom_web bundle exec rails c`
- `docker-compose exec turbo_chatroom_admin_web bundle exec rails c`

