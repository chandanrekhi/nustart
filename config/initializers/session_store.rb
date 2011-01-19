# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_workforastartup_session',
  :secret      => '5f78519e6be943d4f65ad0dc11e66ca265c1e223cb1bad215a78bf7bb4dfd977904ea99f81a15b59519f4a1d9b0986cdc36b15d6285d6ed3b218b7a6cb65e532'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
