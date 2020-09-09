
Pod::Spec.new do |s|
  s.name         = "JHVerificationCodeView"
  s.version      = "1.3.7"
  s.summary      = "A simple Verification Code View."
  s.homepage     = "https://github.com/xjh093/JHVerificationCodeView"
  s.license      = "MIT"
  s.author       = { "Haocold" => "xjh093@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/xjh093/JHVerificationCodeView.git", :tag => s.version }
  s.source_files = "JHVerificationCodeView/JHVerificationCodeView/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
