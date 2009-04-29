# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_kituo_session',
  :secret      => '35c77a0bda0be89509fec56ffb8cf781c23fcbd9064b41adee91ee04d19148b05044c9273da691f8a4da1583647acfe5ac17cbf627ed66235c1ffb20c6b8dfec'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
