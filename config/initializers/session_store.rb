# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kakaku_session',
  :secret      => '03905e9b1e2ac3f355c35bdc7dcf26cece040b8e3d38b71e9a5699cd9eed31185b31999774f9052af875550ce0b4c21d2427e64128b7cf7663cbec52b0f91e1e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
