require_relative './config/environment'

# Parse JSON from the request body into the params hash
use Rack::JSONBodyParser  #this is a middleware. It runs before any other code runs when a post is done or a patch

run ApplicationController
