# YouTube-Cache #

Cache YouTube video files on the proxy server.

## ICAP ##

Tips?

## Squid's store\_url ##

Works with most videos, but not all.

Requires Squid <3.0. Tested on Squid 2.7.

Instructions are available at this [Squid Wiki page](http://wiki.squid-cache.org/ConfigExamples/DynamicContent/YouTube?highlight=%28youtube%29).  Make sure to apply [the patch](http://youtube-cache.googlecode.com/files/patch-youtube) at the very end of that page.

Instead of using the patch above, you can set **minimum\_object\_size** to **512 bytes**.  This should work with all videos, but will decrease your hit rate.<br>
To avoid the hit rate decrease problem, you can use two instances of Squid.  The one dedicated to video files can then use the <b>minimum_object_size</b> option, while the main Squid instance uses <a href='http://code.google.com/p/youtube-cache/source/browse/trunk/squid/youtube_cache_peer.conf'>the cache_peer option</a>.<br>
<br>
<h2>YouTube.php</h2>

Worked with all the videos I tested.<br>
<br>
Seeking to the middle of a video and then going back to the beginning sometimes did not work.  It was happening because some browser/flash combinations were using Range requests.  It should work now.<br>
<br>
Click on <a href='http://code.google.com/p/youtube-cache/source/browse/trunk/php'>Source &gt; trunk &gt; php</a> to download the three source files and follow the <a href='Installation.md'>installation instructions</a>.<br>
<br>
<h2>nginx</h2>

Worked with all the videos I tested.<br>
<br>
Seems to be the best option, save for one minor detail: <a href='http://forum.nginx.org/read.php?2,171950'>files will always be downloaded completely, even if the requesting client has already disconnected</a>.<br>
<br>
Click on <a href='http://code.google.com/p/youtube-cache/source/browse/trunk/nginx'>Source &gt; trunk &gt; nginx</a> for a sample configuration and a Squid URL redirector.<br>
Instead of a URL redirector, you can use <a href='http://code.google.com/p/youtube-cache/source/browse/trunk/squid/youtube_cache_peer.conf'>the cache_peer option</a>.<br>
<br>
TODO: The URL redirector should probably check the values in <b>id</b> and <b>itag</b>, since they are used in nginx's <b>proxy_store</b>.<br>
<br>
<hr />

You can contact me at andre.netvision.com.br -AT- gmail.com.