source :rubygems

gem 'rails', '~> 2.3',
  :require => false

gem 'aws-s3',
  :require => false
gem 'english',
  :require => 'english/soundex'
gem 'haml'
gem 'heroku-environment'
gem 'pg'
gem 'prawn',
  :git => 'git://github.com/sandal/prawn.git',
  :tag => '0.10.2',
  :submodules => true
gem 'prawnto'
gem 'paperclip'
gem 'routing-filter'

group :development do
  gem 'heroku',
    :require => false
  gem 'mysql2',
    :require => false
  gem 'taps',
    :require => false
end

group :test do
  gem 'faker'
  gem 'machinist',
    :require => 'machinist/active_record'
  gem 'matchy',
    :git => 'git://github.com/jm/matchy.git',
    :ref => '11861585c728be71382321221391b118d2106d88'
  gem 'redgreen',
    :require => false
  gem 'shoulda'
end

group :cucumber do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'machinist',
    :require => 'machinist/active_record'
end

group :production do
  gem 'rack-ssl',
    :require => 'rack/ssl'
end
