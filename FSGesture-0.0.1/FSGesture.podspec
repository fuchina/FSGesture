Pod::Spec.new do |s|
  s.name = "FSGesture"
  s.version = "0.0.1"
  s.summary = "FSGesture is a tool for show logs when app run"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"fudon"=>"1245102331@qq.com"}
  s.homepage = "https://github.com/fuchina/FSGesture"
  s.description = "This is a very small software library, offering a few methods to help with programming."
  s.frameworks = "UIKit"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/FSGesture.framework'
end
