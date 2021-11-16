Pod::Spec.new do |s|
    s.name         = 'Genything'
    s.version      = '0.0.1'
    s.license      = { :type => 'CUSTOM', :file => 'LICENSE' }
    s.homepage     = 'https://bitbucket.org/skipthedishes/swifttestingfixtures/'
    s.authors      = { 'SkipTheDishes Restaurant Services Inc.' => 'nicolas.richard@justeattakeaway.com' }
    s.summary      = 'Generate anything!'
    s.source       = { :git => 'git@github.com:justeattakeaway/Genything.git', :tag => 'v0.0.1' }

    s.ios.deployment_target = '11.0'
    s.tvos.deployment_target = '11.0'
    s.watchos.deployment_target = '5.0'
    s.osx.deployment_target = '10.14'

    s.swift_version = '5.0'

    s.source_files = ["Sources/Genything/**/*.{swift,h,m,c}"]
  end
