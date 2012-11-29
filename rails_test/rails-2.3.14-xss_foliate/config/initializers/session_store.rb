# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails-2.3.8-xss_foliate_session',
  :secret      => 'c22f988a4a55e6e62150a93b46d1973be4cb5f8b38d349022935ac96ca42943296236148d2d96fd767f6a4c371ba0c3e9bb3f8bf3606d5389d94f0fa43869229'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
