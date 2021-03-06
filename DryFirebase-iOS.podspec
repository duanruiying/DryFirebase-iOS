#
# Be sure to run `pod lib lint DryFirebase-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 提交仓库:
# pod spec lint DryFirebase-iOS.podspec --allow-warnings
# pod trunk push DryFirebase-iOS.podspec --allow-warnings
#

Pod::Spec.new do |s|
  
  # Git
  s.name        = 'DryFirebase-iOS'
  s.version     = '1.0.0'
  s.summary     = 'DryFirebase-iOS'
  s.homepage    = 'https://github.com/duanruiying/DryFirebase-iOS'
  s.license     = { :type => 'MIT', :file => 'LICENSE' }
  s.author      = { 'duanruiying' => '2237840768@qq.com' }
  s.source      = { :git => 'https://github.com/duanruiying/DryFirebase-iOS.git', :tag => s.version.to_s }
  s.description = <<-DESC
  TODO: Google Firebase功能简化集成(推送、统计、崩溃上报).
  DESC
  
  # User
  #s.swift_version         = '5.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc          = true
  s.user_target_xcconfig  = {'OTHER_LDFLAGS' => ['-w', '-ObjC']}
  
  # Pod
  s.static_framework      = true
  s.pod_target_xcconfig   = {'OTHER_LDFLAGS' => ['-w']}
  
  # Code
  s.source_files          = 'DryFirebase-iOS/Classes/Code/**/*'
  s.public_header_files   = 'DryFirebase-iOS/Classes/Code/Public/**/*.h'
  
  # System
  #s.libraries  = 'z'
  s.frameworks = 'UIKit', 'Foundation'
  
  # ThirdParty
  #s.vendored_libraries  = ''
  #s.vendored_frameworks = ''
  s.dependency 'Firebase/Core'
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/Messaging'
  s.dependency 'Fabric'
  s.dependency 'Crashlytics'
  
end
