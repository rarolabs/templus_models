# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += [ 'appviews.css', 'cssanimations.css',
                               'dashboards.css', 'forms.css',
                               'gallery.css', 'graphs.css',
                               'mailbox.css', 'miscellaneous.css',
                               'pages.css', 'tables.css',
                               'uielements.css', 'widgets.css' ]

Rails.application.config.assets.precompile += [ 'appviews.js', 'cssanimations.js',
                              'dashboards.js', 'forms.js', 
                              'gallery.js', 'graphs.js', 
                              'mailbox.js', 'miscellaneous.js',
                              'pages.js', 'tables.js', 
                              'uielements.js', 'widgets.js', 'crud.js',
                              'crud/*.js' ]

Rails.application.config.assets.precompile += [ 'green.png' ]
