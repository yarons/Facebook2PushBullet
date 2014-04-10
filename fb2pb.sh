#!/bin/bash

#### This is Fb2Pb (Facebook to PushBullet) push script v1.0
#### Basically it can be used for any RSS feed.
#### Before you make your own version of it please make sure to visit
#### The LICENSE file that comes with it.

#### WARNING: When you make any changes make sure you don't
#### add any of your personal settings with the script.
#### All of the hashes included are unique and can allow a potential
#### abuse of your Facebook or PushBullet account.

#### Here you'll have to add your Facebook Notification RSS
#### You can get it by clicking the RSS link at the top of the following page:
#### https://www.facebook.com/notifications
FB_NOTIF_URL='YOUR_FACEBOOK_NOTIFICATION_RSS_URL_HERE'

#### Here you'll have to insert your PushBullet API Key (Be careful not to remove it ☺):
#### https://www.pushbullet.com/account
PB_API_KEY=YOUR_PUSHBULLET_API_KEY_HERE

#### The device identification string can be acquired using
#### the following method:
#### In your PushBullet Inbox screen click the required device
#### At the address bar you'll see that the URL changed to:
####      https://www.pushbullet.com/push/note?device_iden=XXXXXXXX
#### Copy the hash that comes after the device_iden= part (without the equal sign)
PB_DEV_IDEN=YOUR_DEVICE_IDENTIFICATION_HASH_HERE

#### Feel free to set the check interval to whatever you like
#### The supported syntax is:
#### X[s|m|h|d] (X must be an integer)
#### Example: 1 hour would be 1h, 3 days would be 3d
INTERVAL=1m

function pb() {
curl https://api.pushbullet.com/api/pushes \
      -u $PB_API_KEY: \
      -d device_iden=PB_DEV_IDEN \
      -d type=note \
      -d title="Facebook notification" \
      -d body="$now" \
      -X POST
}

last=""
while true
do
    now="$(curl -s $FB_NOTIF_URL | awk '/title/ ,/pubDate/' | grep 'title\|pubDate' | sed -e 's/<[^!>]*>//g' | sed 's/^\s*//g' | grep -Po '(?<=TA\[)(.*)(?=\]\])|^([^<]*)(?=\s\-)' | perl -pe 's/(?<=[^\d])\n/ /g' | head -1)"
    test "$last" != "$now" && pb
    last="$now"
    sleep 1m
done
