# finance-network

This application runs on Rails. I chose Rails simply because it is the framework I am most comfortable
with.

repo: github.com/rserickson92

# Installing Ruby on Rails

Setting up a Rails environment (and dev environments in general) can be painful. This section hopes
to make things a little easier.

Dependencies: node.js

1. [Install Ruby with RVM](https://rvm.io/rvm/install). This is my recommended way to get ruby.
2. Install Rails: in a terminal, run "gem install rails"

And that should hopefully be it!

#Running

Note: Steps 2 and 3 should only be necessary once.

1. Go to the root directory of the project
2. Run "bundle install", this will install dependencies.
3. Run "rake db:migrate" to prepare the database tables.
4. Run "rails server"
5. Open a browser (I recommend Chrome, this is what I developed with) and navigate
to localhost:3000. 
You should see a blank page. From here, the page will be populated whenever
you submit POST requests to the endpoints. Unfortunately this is not in real-time... yet.

# Data Models
I store the JSON data sent to the API endpoints in Rails's default SQLite database in an Agent table
and an Event table. The fields
are almost exactly the same. I did some type conversions for convenience (e.g. I store the floats
as ints).

# Uh-oh, I broke the app!
Note: The only validation the app does at this time is enforcing unique agent names. It is not
bulletproof.

Here are some things you can do:

1. Try emptying the database. You can do this by running the following from the root directory:
rake db:drop
rake db:create
rake db:migrate

2. Clone the repository and start over.
