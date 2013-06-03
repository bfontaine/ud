Gem::Specification.new do |s|
    s.name          = 'ud'
    s.version       = '0.1.0'
    s.date          = Time.now

    s.summary       = 'Urban Dictionary unofficial scrapper'
    s.description   = 'Get words\' definitions from Urban Dictionary on the command-line.'
    s.license       = 'MIT'

    s.author        = 'Baptiste Fontaine'
    s.email         = 'batifon@yahoo.fr'
    s.homepage      = 'https://github.com/bfontaine/ud'

    s.files         = ['lib/ud.rb']
    s.test_files    = Dir.glob('spec/*tests.rb')
    s.require_path  = 'lib'
    s.executables  << 'ud'
end
