WATIR with headless example
-----------

Scraping first 30 results from google (limited because google blocks IP when to many requests occur)
Presenting only headlines on console.
Demonstration purpose only.

INSTALL
-------

~~~bash
sudo apt-get install xvfb
~~~


HOW TO RUN:
-----------

~~~bash
ruby lib/core.rb "other text"
~~~

or by default

~~~bash
ruby lib/core.rb
~~~

> by default will go with "charlie sheen winning"

TODO (possible improvements):
----
* add sh script to run it from root directory
* refactor google method to some general_purpose scraping path with custom strategies like:

~~~ruby
  scrap_strategy("www.somesite.com") do |wraper|
    #browser.start
    wraper.specific.methods
    wraper.goes.here
    #scraping iteration
    #browser.stop
  end
~~~


WARNING
------------

This program violates GOOGLE search ToS, use it for own responsibility
It has been written for tutorial purpose only.
Your IP can be temporarily blocked after heavy overuse of this software.