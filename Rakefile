require 'inch'

task :default => [ :test ]

task :test do
  ruby '-Ilib tests/tests.rb'
end

task :doctest do
  Inch::CLI::Command::Suggest.new.run('--pedantic')
end

task :build do
  system "gem", "build", "./ud.gemspec"
end
