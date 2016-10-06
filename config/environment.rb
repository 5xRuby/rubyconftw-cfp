# Load the Rails application.
require_relative 'application'

# Define new Mime type
Mime::Type.register "application/yml", :yml

# Initialize the Rails application.
Rails.application.initialize!
