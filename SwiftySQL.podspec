Pod::Spec.new do |s|
  s.name             = "SwiftySQL"
  s.version          = "1.0.0"
  s.summary          = "Write you SQL in Swift"
  s.homepage         = "https://github.com/inkyfox/SwiftySQL"
  s.license          = 'MIT'
  s.author           = { "Yongha Yoo" => "inkyfox@oo-v.com" }
  s.source           = { :git => "https://github.com/inkyfox/SwiftySQL.git", :tag => s.version.to_s }
  s.requires_arc          = true
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'
  s.source_files          = 'Sources/*.swift', 'Sources/Models/*.swift', 'Sources/Generators/*.swift'
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '3.0'
  }
end
