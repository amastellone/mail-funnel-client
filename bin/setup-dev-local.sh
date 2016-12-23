#!/usr/bin/env bash

cd ~/Code/Rails/mail-funnel-server-api/
~/Code/Rails/mail-funnel-server-api/bin/rails db:reset
~/Code/Rails/mail-funnel-server-api/bin/rails s -p 3001

cd ~/Code/Rails/mail-funnel-client/
~/Code/Rails/mail-funnel-client/bin/rails db:reset
~/Code/Rails/mail-funnel-client/bin/bundle exec rails server