require './lib/ud'

Gem::Specification.new do |s|
    s.name          = 'ud'
    s.version       = UD.version
    s.date          = Time.now

    s.summary       = 'Urban Dictionary unofficial scrapper'
    s.description   = 'Get words\' definitions from Urban Dictionary on the command-line.'
    s.license       = 'MIT'

    s.author        = 'Baptiste Fontaine'
    s.email         = 'batifon@yahoo.fr'
    s.homepage      = 'https://github.com/bfontaine/ud'

    s.files         = ['lib/ud.rb', 'lib/ud/formatting.rb']
    s.test_files    = Dir.glob('tests/*tests.rb')
    s.require_path  = 'lib'
    s.executables  << 'ud'

    s.add_runtime_dependency 'nokogiri', '~>1.5.9'
    s.add_runtime_dependency 'json',     '>= 1.8.0'
    s.add_runtime_dependency 'trollop',  '~>2.0'

    s.add_development_dependency 'simplecov'
    s.add_development_dependency 'rake'
    s.add_development_dependency 'test-unit'
    s.add_development_dependency 'fakeweb'
end
