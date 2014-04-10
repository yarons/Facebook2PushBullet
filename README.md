Facebook2PushBullet
===================

You can use this script in one of the following ways:
1. With an internal loop and a sleep in it.
2. Cronjob (Some changes should be made for this to work).

### As for the RSS itself:

Since it's a Facebook adaptation I only used 2 fields: title and pubDate, any other implementation such as
adding a description will probably require some changed to the very long and tedious set of pipes after
the curl -s 'URL' command but it's most certainly possible.

Since no changes are made to the text, the script automagically supports UTF-8 (as long as your terminal does).

### The downsides I'm currently working to improve:

1. The script will only send the last message after the specified interval and not all the messages (should implement a silent diff and sent the lines one by one to PushBullet).
2. The script is not restart tollerant and will send the last message again even if it was already sent (Can be fixed using an external data file).


### WHY NOT IFTTT?

Come on, I feel exposed enough with FB, do I really need an additional party to access my personal details?
If this project will go forward I plan to build some additional parsers using bash to imitate the functionalities of IFTTT.

### WHY NOT USING AN XML PARSER?

Is ruining my fun your main goal in life? ☺

### My inspiration

http://unix.stackexchange.com/questions/22137/how-to-watch-rss-feed-for-new-entries-from-bash-script
Thanks guys!

Feel free to fork and improve.
