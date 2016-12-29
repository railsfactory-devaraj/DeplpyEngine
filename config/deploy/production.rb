# server-based syntax
# ======================
server ENV['HOSTS'], user: 'deployuser', roles: %w{app web}

# role-based syntax
# ==================
role :app, %w{deployuser@ENV['HOSTS']}

# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.


# Custom SSH Options
# ==================
set :ssh_options, {
  keys: %w(~/.ssh/id_rsa),
  port: 22,
  forward_agent: false,
  auth_methods: %w(publickey),
}
