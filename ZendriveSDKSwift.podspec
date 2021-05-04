Pod::Spec.new do |s|
  s.name             = "ZendriveSDKSwift"
  s.version          = "7.0.0"
  s.summary          = "Zendrive iOS SDK"
  s.homepage         = "http://www.zendrive.com"
  s.license          = "Apache License, Version 2.0"
  s.author           = { "Zendrive Inc." => "zendrive" }
  s.swift_version  = '5.0'
  s.static_framework = true
  s.cocoapods_version = '>= 1.9.0'
  s.platform         = :ios, '11.0'
  s.source           = { :git => "https://bitbucket.org/zendrive-root/zendrive_cocoapod.git", :tag => "#{s.version}" }
  s.requires_arc     = true
  s.static_framework = true
  s.source_files     = 'Swift/*.swift'
  s.module_name = 'ZendriveSDKSwift'
  s.dependency "ZendriveSDK"
  
end
