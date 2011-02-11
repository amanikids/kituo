desc 'Generate a developer-local configuration file.'
# The heroku-environment gem reads this file to set environment variables. It's
# a nice way of replicating heroku's feel locally, and of keeping the app code
# clean.
file '.environment' do |task|
  environment = {
    'AMAZON_ACCESS_KEY_ID'     => 'Set to use script/s3console.',
    'AMAZON_SECRET_ACCESS_KEY' => 'Set to use script/s3console.',
    'SECRET_TOKEN'             => ActiveSupport::SecureRandom.hex(64)
  }

  Rails.root.join(task.name).open('w') do |io|
    YAML.dump(environment, io)
  end
end
