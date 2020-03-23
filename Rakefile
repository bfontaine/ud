require 'inch/rake'

task :default => [ :test ]

task :test do
  ruby '-Ilib tests/tests.rb'
end

task :doctest do
  Inch::Rake::Suggest.new { |s| s.args << '--pedantic' }
end

task :build do
  system "gem", "build", "./ud.gemspec"
end
