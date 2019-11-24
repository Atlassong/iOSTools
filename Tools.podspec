#
# Be sure to run `pod lib lint Tools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Tools'
  s.version          = '0.2.1'
  s.summary          = 'iOS开发基础工程库，集成常见方法.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  iOS开发基础工程库，集成常见方法
                       DESC

  s.homepage         = 'https://github.com/xiang.song/Tools'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xiang.song' => 'songxiang2010@163.com' }
  s.source           = { :git => 'git@github.com:Atlassong/iOSTools.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Tools/Classes/Category/*','Tools/Classes/Common/*','Tools/Classes/SpriteKit/*'
  
  # s.resource_bundles = {
  #   'Tools' => ['Tools/Assets/*.png']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'CoreTelephony', 'Foundation', 'SpriteKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
