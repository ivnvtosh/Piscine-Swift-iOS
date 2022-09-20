#
# Be sure to run `pod lib lint ccamie2022.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ccamie2022'
  s.version          = '0.1.0'
  s.summary          = 'Prepare all the necessary ingredients.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Whisk the eggs together with sugar, salt and baking soda in a bowl. You can use an egg whisk.
                       DESC

  s.homepage         = 'https://github.com/87498837/ccamie2022'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '87498837' => 'ivnvtosh@icloud.com' }
  s.source           = { :git => 'https://github.com/87498837/ccamie2022.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'ccamie2022/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ccamie2022' => ['ccamie2022/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Coredata'
  s.swift_version = '5.6.1'
  # s.dependency 'AFNetworking', '~> 2.3'

end
