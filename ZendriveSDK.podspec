Pod::Spec.new do |s|
  s.name           = "ZendriveSDK"
  s.version        = "7.0.0"
  s.summary        = "Zendrive iOS SDK"
  s.homepage       = "http://www.zendrive.com"
  s.license        = 'Apache License, Version 2.0'
  s.author         = { "Zendrive Inc." => "zendrive" }
  s.swift_version  = '5.0'
  s.static_framework = true
  s.cocoapods_version = '>= 1.9.0'
  s.platform       = :ios, '11.0'
  s.source         = { :git => "https://bitbucket.org/zendrive-root/zendrive_cocoapod.git", :tag => "#{s.version}" }
  s.libraries      = "z.1.1.3", "sqlite3", "c++"
  s.requires_arc = true
  s.default_subspec = 'Standard'

  s.subspec 'Standard' do |ss|
    ss.vendored_frameworks = 'ZendriveSDK.xcframework'
    ss.frameworks     = "Accelerate", "SystemConfiguration", "CoreLocation", "CoreMotion", "CoreTelephony"
    ss.dependency "AWSCore", '~>2.11.1'
    ss.dependency "AWSSQS", '~>2.11.1'
    ss.dependency "SQLite.swift", '~>0.12.0'
  end

  s.subspec 'Testing' do |ss|
    ss.dependency 'ZendriveSDK/Standard'
    ss.ios.vendored_frameworks = 'ZendriveSDKTesting.framework'
  end

end
