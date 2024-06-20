#
# Be sure to run `pod lib lint QNRequest.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.swift_versions = ['5.0']
  s.name             = 'QNRequest'
  s.version          = '2.3.1'
  s.summary          = 'A short description of QNRequest.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/quannguyen90/QNRequest'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'quannguyen90' => 'quannv.tm@gmail.com' }
  s.source           = { :git => 'https://github.com/quannguyen90/QNRequest.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.source_files = 'QNRequest/Classes/**/*'
  s.dependency 'Alamofire', '~> 4.9.1'
end
#/Users/quannguyen/Documents/iOSProject/Lib/QNRequest/Example/QNRequest.xcodeproj
#pod
