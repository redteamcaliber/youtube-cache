# YouTube-Cache Installation #

Each video is stored in one individual file.  You can delete any of these files at any time.  There is no need to stop the proxy to do so. Squid must be configured to not cache any video file coming from the web server, the PHP script will do the caching itself.

Tested with Apache 2.2.17, PHP 5.3.5, Squid 2.7.9 (3.x as well).

## Configuration ##

  * In config.php
    * As the name implies, this is the configuration file for **youtube.php**. The only thing you do need to change in this file is the e-mail address.
    * Make sure the directory specified in **cachedir** is writable by the PHP script.
  * In cache.rb
    * Change the first line to your ruby interpreter.
    * Search for **youtube.php** and set it to the correct URL.

Now, set Squid to use **cache.rb** as a URL redirector and try to watch a video on YouTube. **cache.rb** and **youtube.php** use syslog to describe what they're doing.  If you don't see anything being logged, your Squid configuration is probably not correct.