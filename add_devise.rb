# use following command to execute
# rails app:template LOCATION=add_devise.rb

# Add gem
gem 'devise', '~> 4.7'

run 'bundle install'

# reflash cache
run 'spring stop'

# Install Devise
generate "devise:install"

# Configure Devise
environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'

route "root to: 'home#index'"
generate :controller, "home", "index"

#add message
content = <<-RUBY
  <a class="" href="/">Home</a>
  <% if user_signed_in? %>
  <%= link_to "Edit profile", edit_user_registration_path, class: '' %>
  <%= link_to "Logout", destroy_user_session_path, method: :delete, class: ''  %>
  <% else %>
  <%= link_to "Sign Up!", new_user_registration_path, class: ''  %>
  <%= link_to "Login", new_user_session_path, class: ''  %>
  <% end %>
  <p class="notice"><%= notice %></p>
  <p class="alert"><%= alert %></p>
RUBY
insert_into_file "app/views/layouts/application.html.erb", "\n#{content}\n", after: "<body>"

# Create Devise User
generate :devise, "User", "admin:boolean"

# Set admin boolean to false by default
in_root do
  migration = Dir.glob("db/migrate/*").max_by{ |f| File.mtime(f) }
  gsub_file migration, /:admin/, ":admin, default: false"
end
rails_command "db:migrate"
