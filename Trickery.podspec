Pod::Spec.new do |s|
    s.name         = 'Trickery'
    s.version      = '1.0.0'
    s.license      = { :type => 'CUSTOM', :file => 'LICENSE' }
    s.homepage     = 'https://github.com/justeattakeaway/Genything'
    s.authors      = { 'SkipTheDishes Restaurant Services Inc.' => 'nicolas.richard@justeattakeaway.com' }
    s.summary      = 'Trick yourself with this fake data.'
    s.source       = { :git => 'https://github.com/justeattakeaway/Genything.git', :tag => '1.0.0' }

    s.ios.deployment_target = '11.0'
    s.tvos.deployment_target = '11.0'
    s.watchos.deployment_target = '5.0'
    s.osx.deployment_target = '10.14'

    s.swift_version = '5.0'

    s.source_files = ["Sources/Trickery/**/*.{swift,h,m,c}"]
    s.resource_bundle = { 'Trickery' => 'Sources/Trickery/Resources/**/*.{json}' }

    s.dependency 'Genything', '1.0.0'
  end
