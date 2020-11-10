#
# Be sure to run `pod lib lint Tools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Tools'
  s.version          = '0.3.4'
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

  s.subspec 'Network' do |a|
    a.source_files = 'Tools/Classes/Network/*'
  end

  s.subspec 'SpriteKit' do |a|
    a.source_files = 'Tools/Classes/SpriteKit/*'
  end

  s.subspec 'Category' do |a|
    a.source_files = 'Tools/Classes/Category/*'
  end

  s.subspec 'Common' do |a|
    a.source_files = 'Tools/Classes/Common/*'
  end

  s.subspec 'Function' do |a|
    a.source_files = 'Tools/Classes/Function/*'
  end

  s.frameworks = 'CoreTelephony', 'Foundation', 'SpriteKit'
  s.dependency 'AFNetworking/NSURLSession', '~> 3.1.0'
  s.dependency 'ReactiveObjC', '3.1.1'
end
