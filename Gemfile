source 'http://rubygems.org/'

gem 'english',  :require => 'english/soundex'
gem 'haml'
gem 'pg'
gem 'prawn',    :require => ['prawn', 'prawn/layout']
gem 'prawnto'
gem 'paperclip'
gem 'rails',    :require => false

group :development do
  gem 'capistrano', :require => false
  gem 'cap_gun',    :require => false
  gem 'highline',   :require => false
end

group :test do
  gem 'chronic'
  gem 'cucumber'
  gem 'faker'
  gem 'machinist',       :require => 'machinist/active_record'
  gem 'redgreen',        :require => false
  gem 'selenium-client', :require => false
  gem 'selenium-rc',     :require => false
  gem 'shoulda',         :require => false
  gem 'webrat'

  gem 'matchy',
        :git => 'git://github.com/jm/matchy.git',
        :ref => '11861585c728be71382321221391b118d2106d88'
end
