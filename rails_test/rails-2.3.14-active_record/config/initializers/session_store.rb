# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_rails-2.3.8-active_record_session',
  :secret      => 'a4f93d6b4e4c33d4abac95ee3bce97a127f3a8823d5d81fc7764cdb77eaf3d671bdf382e51c7bc7918e8e946dc80cb09310203e71954f1bb31837b907bab95bc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
