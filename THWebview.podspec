
Pod::Spec.new do |spec|

  spec.name         = "THWebview"
  spec.version      = "1.0.0"
  spec.summary      = "Super Easy WKWebView for simple web page."
  spec.description  = "This library is Super Easy WKWebView for simple web page."
  spec.homepage     = "https://github.com/aboutyu/THWebview"
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.author       = { "James" => "aboutyu@gmail.com" }
  spec.source       = { :git => "https://github.com/aboutyu/THWebview.git", :tag => spec.version.to_s }
  spec.ios.deployment_target = '11.0'
  spec.source_files  = "THWebview/Modules/*.swift"

end
