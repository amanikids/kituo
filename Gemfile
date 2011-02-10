source 'http://rubygems.org/'

gem 'rails', '~> 2.3', :require => false

gem 'aws-s3',   :require => false
gem 'english',  :require => 'english/soundex'
gem 'haml'
gem 'pg'
gem 'prawn',    :require => ['prawn', 'prawn/layout']
gem 'prawnto'
gem 'paperclip'
gem 'routing-filter'

group :test do
  gem 'faker'
  gem 'machinist', :require => 'machinist/active_record'
  gem 'redgreen',  :require => false
  gem 'shoulda'

  gem 'matchy',
        :git => 'git://github.com/jm/matchy.git',
        :ref => '11861585c728be71382321221391b118d2106d88'
end

group :cucumber do
  gem 'capybara'
  gem 'cucumber-rails'
  gem 'database_cleaner'
  gem 'faker'
  gem 'launchy'
  gem 'machinist', :require => 'machinist/active_record'
end
