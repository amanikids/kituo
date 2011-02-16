Paperclip::Attachment.default_options.tap do |options|
  options.merge({
    :default_style => :default,
    :default_url   => '/images/:attachment-:style.jpg',
    :styles        => { :default => '150x150#' }
  })

  if Rails.env.production?
    options.merge({
      :storage        => :s3,
      :bucket         => ENV['S3_BUCKET'],
      :path           => '/:class/:attachment/:id/:style/:filename',
      :s3_credentials => {
        :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
        :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
      }
    })
  else
    options.merge({
      :url => '/system/:class/:attachment/:id/:style/:filename'
    })
  end
end
