#
# Be sure to run `pod lib lint ALObserverManager.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ALObserverManager"
  s.version          = "0.1.2"
  s.summary          = "ALObserverManager is a custom alertView"
  s.description      = <<-DESC.gsub(/^\s*\|?/,'')
                       ALObserverManager is a custom alertView for you!
                       DESC
  s.homepage         = "https://github.com/alex520biao/ALObserverManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'BSD'
  s.author           = { "alex520biao" => "alex520biao@163.com" }
  s.source           = { :git => "https://github.com/alex520biao/ALObserverManager.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.source_files = 'Pod/Classes/**/*'

  # Uncomment following lines if ALObserverManager has some resource files.
  # s.resource_bundles = {
  #   'ALObserverManager' => ['Pod/Assets/*.png']
  # }

  # Uncomment following lines if ALObserverManager needs to link with some static libraries.
  # s.vendored_libraries = [
  #   'Pod/lib/a-static-library.a',
  # ]

  # Uncomment following lines if ALObserverManager depends on any system framework.
  # s.frameworks = 'UIKit', 'MapKit'

  # Uncomment following lines if ALObserverManager depends on any public or private pod.
  # s.dependency 'AFNetworking', '~> 2.5.4'
  # s.dependency 'JSONModel', '~> 1.1.0'
  # s.dependency 'libextobjc', '~> 0.4.1'
    s.dependency 'ReactiveCocoa'
  # s.dependency 'ReactiveViewModel', '~> 0.3.0'

end
