Ranked.
=======

Ranked is a website where users can create a list of things, such as baseball
teams or colors or baby names, and they and other users can then rank those
items. Ranking is done by presenting the user with each possible pair of items,
and having the user choose the better of the two. The results of each of these
matches is then given to an implementation of the Elo algorithm to determine the
score and therefore final ranking.

Architecture
------------

The website is architected to use the database and backend as little as
possible. The {Stack} record contains multiple {Card} records, one for each item
to be ranked. No other data is stored in the database. As users complete
matches, the result of each match is encoded in the URL. When the user wishes to
see their ranking, the encoded results array is included in the final ranking
URL. This allows users to share their results with others without the
application needing to save their results to a database.

The backend is a Ruby on Rails application and PostgreSQL database deployed
using Heroku. There is no authentication, nor any need for user accounts. See
{ApplicationController} for more information about controller API responses.

The front-end is Vue.js and Vue-Router, compiled using Webpack via the Webpacker
gem. Babel is used to transpile ECMAScript stage-3 code.

Documentation
-------------

Comprehensive documentation of all Ruby on Rails controllers and models is
available by running `rake yard` and opening the generated HTML website in
`doc/app`.

No documentation for the Vue.js front-end is available yet.

Tests
-----

Models have comprehensive unit tests, and controllers comprehensive integration
tests, using RSpec and FactoryGirl. Specs can be run using `rspec spec`.

No tests of the Vue.js front-end are available yet.
