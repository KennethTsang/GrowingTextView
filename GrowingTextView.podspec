#
# Be sure to run `pod lib lint GrowingTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GrowingTextView"
  s.version          = "0.1.2"
  s.summary          = "UITextView with support of auto growing, placeholder and length limit."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
This cocoapods provide a subclass of UITextView which support auto growing, placeholder and length limit.
                       DESC

  s.homepage         = "https://github.com/BigSmallDog/GrowingTextView"
  s.screenshots      = "https://raw.githubusercontent.com/BigSmallDog/GrowingTextView/master/DEMO.gif"
  s.license          = 'MIT'
  s.author           = { "BigSmallDog" => "doglittlebig@gmail.com" }
  s.source           = { :git => "https://github.com/BigSmallDog/GrowingTextView.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GrowingTextView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
