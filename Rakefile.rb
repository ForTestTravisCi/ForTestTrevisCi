# task :test do
#   system 'cucumber'
# end

task :default do
  system 'cucumber'
end

task :validate do
  system 'gem install rubocop'
  system 'rubocop'
end

# task :delete => [:purge, :delete_inbox_emails]

task :purge do
  rm(Dir['screenshot/screenshot*'])
  rm(Dir['reports/*.html'])
  # remove_file('Gemfile.lock')
  puts 'Reports deleted'
end

# task :delete_inbox_emails do
#   require_relative './helpers/email_helper'
#
#   delete_messages = EmailHelper.new
# p  delete_messages.delete_all
# end
