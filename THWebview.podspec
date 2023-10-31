
Pod::Spec.new do |spec|

  spec.name             = "THWebview"
  spec.version          = "1.1.1"
  spec.summary          = "Super Easy WKWebView for simple web page."
  spec.description      = "This library is Super Easy WKWebView for simple web page."
  spec.homepage         = "https://github.com/aboutyu/THWebview"
  spec.license          = { :type => "MIT", :file => "LICENSE" }
  spec.author           = { "James" => "aboutyu@gmail.com" }
  spec.platform         = :ios, "11.0"
  spec.swift_version    = '5.0'
  spec.swift_version    = spec.swift_version.to_s
  spec.source           = { :git => "https://github.com/aboutyu/THWebview.git", :tag => spec.version }
  spec.source_files     = "THWebview/modules/*.swift"

end