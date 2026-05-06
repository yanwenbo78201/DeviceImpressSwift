#
# Be sure to run `pod lib lint DeviceImpressSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DeviceImpressSwift'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DeviceImpressSwift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/yanwenbo78201/DeviceImpressSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yanwenbo78201' => 'yanwenbo_78201@163.com' }
  s.source           = { :git => 'https://github.com/yanwenbo78201/DeviceImpressSwift.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '14.0'
  s.swift_version = '5.0'

  s.source_files = 'DeviceImpressSwift/Classes/**/*'
  
    # 仅入口放在根 spec，避免与各 subspec 目录下的源码重复编译。
  s.source_files = 'DeviceImpressSwift/Classes/SystemService.swift'

  # `pod 'DeviceImpressSwift'` 默认依赖全部 subspec；也可只选其一，例如 `pod 'DeviceImpressSwift/Network'`。
  # 勿将 .swift 写入 public_header_files，否则 CocoaPods 会生成错误的 umbrella（#import "*.swift"）。

  s.subspec 'Network' do |network|
    network.source_files = 'DeviceImpressSwift/Classes/Network/**/*'
    network.frameworks = 'UIKit', 'CoreTelephony', 'AppTrackingTransparency'
  end

  s.subspec 'Broken' do |broken|
    broken.source_files = 'DeviceImpressSwift/Classes/Broken/**/*'
    broken.frameworks = 'UIKit'
  end

  s.subspec 'Storage' do |storage|
    storage.source_files = 'DeviceImpressSwift/Classes/Storage/**/*'
    storage.frameworks = 'UIKit'
  end

  s.subspec 'Time' do |time|
    time.source_files = 'DeviceImpressSwift/Classes/Time/**/*'
    time.frameworks = 'UIKit'
  end

  s.subspec 'Device' do |device|
    device.source_files = 'DeviceImpressSwift/Classes/Device/**/*'
    device.frameworks = 'UIKit', 'CoreTelephony', 'AppTrackingTransparency', 'AdSupport'
  end
  s.subspec 'Impress' do |impress|
      impress.source_files = 'DeviceImpressSwift/Classes/Impress/**/*'
      impress.frameworks = 'UIKit'
  end

  s.frameworks = 'UIKit', 'CoreTelephony', 'AppTrackingTransparency', 'AdSupport'
end
