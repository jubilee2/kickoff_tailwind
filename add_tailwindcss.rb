run "yarn add tailwindcss"
run "mkdir app/javascript/stylesheets"
append_to_file("app/javascript/packs/application.js", 'import "stylesheets/application"')
inject_into_file("./postcss.config.js", "\n    require('tailwindcss'),", after: "plugins: [")

content = <<-RUBY
@import "tailwindcss/base";
@import "tailwindcss/components";
@import "tailwindcss/utilities";
RUBY
create_file("app/javascript/stylesheets/application.scss", content)
