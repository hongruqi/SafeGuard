#
# Be sure to run `pod lib lint WTSafeGuard.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WTSafeGuard'
  s.version          = '1.3.0'
  s.summary          = 'A short description of WTSafeGuard.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                      防止crash
                       DESC

  s.homepage         = 'https://github.com/hongruqi/SafeGuard'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lbrsilva-allin' => 'hongru.qi@quvideo.com' }
  s.source           = { :git => 'https://github.com/hongruqi/SafeGuard.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'WTSafeGuard/Classes/**/*','WTSafeGuard/Classes/KVO/*','WTSafeGuard/Classes/UI/*', 
  'WTSafeGuard/Classes/Container/*','WTSafeGuard/Classes/Target/*','WTSafeGuard/Classes/Timer/*'
  # s.resource_bundles = {
  #   'WTSafeGuard' => ['WTSafeGuard/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'JRSwizzle'
end
