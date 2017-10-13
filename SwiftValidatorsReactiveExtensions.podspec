#
# Be sure to run `pod lib lint SwiftValidatorsReactiveExtensions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftValidatorsReactiveExtensions'
  s.version          = '4.1.0-alpha.2'
  s.summary          = 'SwiftValidators that play nice with ReactiveSwift\'s ValidatingProperty'

  s.description      = <<-DESC
    ReactiveSwift's ValidatingProperty seems the ideal place to apply SwiftValidators. SwiftValidatorsReactiveExtensions provides extensions that play nice with and remove much of the boilerplate code needed to validate a ValidatingProperty'
                       DESC

  s.homepage         = 'https://github.com/gkaimakas/SwiftValidatorsReactiveExtensions'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gkaimakas' => 'gkaimakas@gmail.com' }
  s.source           = { :git => 'https://github.com/gkaimakas/SwiftValidatorsReactiveExtensions.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'SwiftValidatorsReactiveExtensions/Classes/**/*'

    s.dependency 'SwiftValidators', '~> 7.0.0'
    s.dependency 'ReactiveSwift', '2.1.0-alpha.2'
end
