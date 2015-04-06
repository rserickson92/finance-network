# finance-network

This application runs on Rails. I chose Rails simply because it is the framework I am most comfortable
with.

# Installing Ruby on Rails

Setting up a Rails environment (and dev environments in general) can be painful. This section hopes
to make things a little easier.

Dependencies: node.js

1. [Install Ruby with RVM](https://rvm.io/rvm/install). This is my recommended way to get ruby.
2. Install Rails: in a terminal, run "gem install rails"

And that should hopefully be it!

# Data Models
I store the JSON data sent to the API endpoints in Rails's default SQLite database. The fields
are almost exactly the same, with some type conversions for convenience (e.g. I store the floats
as ints).