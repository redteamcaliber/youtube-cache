# youtube-cache
Automatically exported from code.google.com/p/youtube-cache



Cache YouTube videos
YouTube-Cache

Cache YouTube video files on the proxy server.
ICAP

Tips?
Squid's store_url

Works with most videos, but not all.

Requires Squid <3.0. Tested on Squid 2.7.

Instructions are available at this Squid Wiki page. Make sure to apply the patch at the very end of that page.

Instead of using the patch above, you can set minimum_object_size to 512 bytes. This should work with all videos, but will decrease your hit rate.
To avoid the hit rate decrease problem, you can use two instances of Squid. The one dedicated to video files can then use the minimum_object_size option, while the main Squid instance uses http://code.google.com/p/youtube-cache/source/browse/trunk/squid/youtube_cache_peer.conf'>the cache_peer option.

YouTube.php

Worked with all the videos I tested.

Seeking to the middle of a video and then going back to the beginning sometimes did not work. It was happening because some browser/flash combinations were using Range requests. It should work now.

Click on http://code.google.com/p/youtube-cache/source/browse/trunk/php'>Source > trunk > php to download the three source files and follow the installation instructions.

nginx

Worked with all the videos I tested.

Seems to be the best option, save for one minor detail: http://forum.nginx.org/read.php?2,171950'>files will always be downloaded completely, even if the requesting client has already disconnected.

Click on http://code.google.com/p/youtube-cache/source/browse/trunk/nginx'>Source > trunk > nginx for a sample configuration and a Squid URL redirector.
Instead of a URL redirector, you can use http://code.google.com/p/youtube-cache/source/browse/trunk/squid/youtube_cache_peer.conf'>the cache_peer option.

TODO: The URL redirector should probably check the values in id and itag, since they are used in nginx's proxy_store.

You can contact me at andre.netvision.com.br -AT- gmail.com.

==========

YouTube-Cache Installation

Each video is stored in one individual file. You can delete any of these files at any time. There is no need to stop the proxy to do so. Squid must be configured to not cache any video file coming from the web server, the PHP script will do the caching itself.

Tested with Apache 2.2.17, PHP 5.3.5, Squid 2.7.9 (3.x as well).
Configuration

    In config.php
        As the name implies, this is the configuration file for youtube.php. The only thing you do need to change in this file is the e-mail address.
        Make sure the directory specified in cachedir is writable by the PHP script.
    In cache.rb
        Change the first line to your ruby interpreter.
        Search for youtube.php and set it to the correct URL.

Now, set Squid to use cache.rb as a URL redirector and try to watch a video on YouTube. cache.rb and youtube.php use syslog to describe what they're doing. If you don't see anything being logged, your Squid configuration is probably not correct.
