namespace :development do
  namespace :push do
    task :production do
      Rake::Task['development:push:production:db'].invoke
      Rake::Task['development:push:production:s3'].invoke
    end

    namespace :production do
      task :db do
        sh 'heroku pg:reset --db SHARED_DATABASE_URL --remote production'
        sh 'heroku db:push --remote production'
      end

      task :s3 => :environment do
        require 'aws/s3'
        AWS::S3::Base.establish_connection!(
          :access_key_id     => ENV['AMAZON_ACCESS_KEY_ID'],
          :secret_access_key => ENV['AMAZON_SECRET_ACCESS_KEY']
        )

        Rails.root.join('public', 'system').tap do |root|
          root.find do |path|
            next unless path.file?

            key = path.relative_path_from(root).to_s

            puts key
            AWS::S3::S3Object.store(key, path.read, 'amanikids-kituo')
          end
        end
      end
    end
  end
end
