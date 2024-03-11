# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Rails.application.config.assets.manifest = "#{Rails.root}/config/manifest.json"

# invoice
Rails.application.config.assets.precompile += %w( invoice/review.js invoice.css invoice/confirmation.js invoice/invoice.js invoice/validator.js  invoice/uploads.js invoice/update_status.js invoice/edit.js  )

# product invoice
Rails.application.config.assets.precompile += %w( product_invoice/edit.js  product_invoice/attachment.js)

Rails.application.config.assets.precompile += %w( invoice.css print.css  review/icons.js blockquote.css hr.css)

# contact
Rails.application.config.assets.precompile += %w( contact/update_priority.js  contact/uniq.js)

# admin
Rails.application.config.assets.precompile += %w( admin/user_sites.js admin/toggle_twilio.js )

# etc
Rails.application.config.assets.precompile += %w( mblz/way.js )

# vendor

Rails.application.config.assets.precompile += %w( resizeUpload.js binaryAjax.js exif.js)


Rails.application.config.assets.precompile += %w( jquery-mobile/ajax-loader.gif  jquery-mobile/icons-18-white.png jquery-mobile/icons-18-black.png  jquery-mobile/icons-36-white.png  jquery-mobile/icons-36-black.png )

# Rails.application.config.assets.precompile += %w( ajax-loader.gif icons-18-white.png logo.png )


# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "images")
# Rails.application.config.assets.precompile += %w( ajax-loader.gif icons-18-white.png )

# Rails.application.config.assets.paths << Rails.root.join("app", "assets", "images")
# Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
# Rails.application.config.assets.paths << 'vendor/assets/images'
# Rails.application.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
