Paperclip::Attachment.default_options.merge({
  :default_style => :default,
  :default_url   => '/images/:attachment-:style.jpg',
  :styles        => { :default => '150x150#' }
})

if Rails.env.production?
  Paperclip::Attachment.default_options[:storage] = :s3
  Paperclip::Attachment.default_options[:bucket]  = ENV['S3_BUCKET']
  Paperclip::Attachment.default_options[:path]    = '/:class/:attachment/:id/:style/:basename.:extension'
  Paperclip::Attachment.default_options[:s3_credentials] = {
    :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
    :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
  }
else
  Paperclip::Attachment.default_options[:url] = '/system/:class/:attachment/:id/:style/:basename.:extension'
end
