run "yarn add bootstrap@4.3.1 jquery popper.js"

content = <<-RUBY
const webpack = require('webpack')
environment.plugins.append('Provide', new webpack.ProvidePlugin({
  $: 'jquery',
  jQuery: 'jquery',
  Popper: ['popper.js', 'default']
}))
RUBY
inject_into_file("config/webpack/environment.js", "\n"+content, after: "const { environment } = require('@rails/webpacker')")

# Remove Application CSS
remove_file "app/assets/stylesheets/application.css"
create_file("app/assets/stylesheets/application.scss", '@import "bootstrap/scss/bootstrap";')

append_to_file("app/javascript/packs/application.js", 'require("bootstrap/dist/js/bootstrap")')
