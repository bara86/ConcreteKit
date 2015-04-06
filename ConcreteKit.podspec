# -*- ruby -*-

Pod::Spec.new do |s|
  s.name             = 'ConcreteKit'
  s.version          = '0.1.0'
  s.summary          = 'A collection of utility classes and methods for Swift projects.'
  s.homepage         = 'https://github.com/lvillani/ConcreteKit'
  s.license          = 'MIT'
  s.author           = { 'Lorenzo Villani' => 'lorenzo@villani.me' }
  s.source           = { :git => 'https://github.com/lvillani/ConcreteKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/justlvillani'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'ConcreteKit/*.swift'
end
