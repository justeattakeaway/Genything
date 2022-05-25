Pod::Spec.new do |s|
    s.name         = 'GenythingTest'
    s.version      = '1.0.0'
    s.license      = { :type => 'CUSTOM', :file => 'LICENSE' }
    s.homepage     = 'https://github.com/justeattakeaway/Genything'
    s.authors      = { 'SkipTheDishes Restaurant Services Inc.' => 'nicolas.richard@justeattakeaway.com' }
    s.summary      = 'Generate anything!'
    s.source       = { :git => 'https://github.com/justeattakeaway/Genything.git', :tag => '1.0.0' }

    s.ios.deployment_target = '11.0'
    s.tvos.deployment_target = '11.0'
    s.watchos.deployment_target = '5.0'
    s.osx.deployment_target = '10.14'

    s.swift_version = '5.0'

    s.source_files = 'Sources/GenythingTest/**/*.{swift,h,m}'

    s.framework = 'XCTest'
    s.dependency 'Genything', '1.0.0'
end