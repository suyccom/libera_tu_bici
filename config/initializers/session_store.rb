# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_sgbizi_session',
  :secret      => '4c95ad22c81deb00cc23d596bf8306cac3b379be3b03f6806794a5b6e81b054c98c84d24af473bdca329d8aea405f4578c78f0a84cc3e7045b60cc016f9f43da'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
