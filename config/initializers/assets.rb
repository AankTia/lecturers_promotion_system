# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
# Add the fonts path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

# Rails.application.config.assets.precompile += %w( metronic/global/plugins/excanvas.min.js metronic/global/plugins/respond.min.js )
Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif *.svg *.eot *.woff *.ttf *.woff2)