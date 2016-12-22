Gem::Specification.new do |s|
  s.name          = 'italiansubs'
  s.version       = '0.1.0'
  s.date          = '2016-12-22'
  s.summary       = 'Ruby wrapper for Italian Subs API'
  s.description   = 'A ruby wrapper for Italian Subs API.'
  s.authors       = ['Tommaso Barbato']
  s.email         = 'epistrephein@gmail.com'
  s.files         = ['lib/italiansubs.rb']
  s.homepage      = 'https://github.com/epistrephein/italiansubs'
  s.license       = 'MIT'
  s.require_paths = ['lib']
  s.add_dependency 'faraday', '~> 0.10'
  s.add_dependency 'faraday_middleware', '~> 0.10'
end
