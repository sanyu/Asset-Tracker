# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_prueba_session',
  :secret      => 'f4938d72238d4717e9fb093370a9fc6877c896bd0aad9f781660b574af7d112a2f9d303a3db5ea8fc69dc45c237c5c8d59bdc9e01827371b294bb1dbbfbc86ae'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
