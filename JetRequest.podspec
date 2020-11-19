#
#  Be sure to run `pod spec lint JetRequest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "JetRequest"
s.summary = "Make your API requests easily."
#s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE.txt" }

# 4 - Replace with your name and e-mail address
s.author = { "Yousef" => "yosefali97@hotmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/YousefAnsary/JetRequest"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/YousefAnsary/JetRequest.git",
:tag => "#{s.version}" }

# 7
#s.framework = "UIKit"

# 8
s.source_files = "JetRequest/*.{swift}"

# 9
#s.resources = "JetRequest/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5"

end
