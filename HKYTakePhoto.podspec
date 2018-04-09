

Pod::Spec.new do |s|
  s.name             = "HKYTakePhoto"
  s.version          = "1.0.1"
  s.summary          = "Custom Category used on iOS."
  s.description      = <<-DESC
                       Custom Category used on iOS, which implement by Objective-C.
                       DESC
  s.homepage         = "https://github.com/Auber2071/HKYTakePhoto"
  s.license          = 'MIT'
  s.author           = { "xinzhang" => "zx270611346@gmail.com" }
  s.platform         = :ios, '7.0'
  s.source           = { :git => "https://github.com/Auber2071/HKYTakePhoto.git", :tag => s.version }
  s.source_files     = 'class','HKYTakePhoto/class/**/*.{h,m}'
  s.requires_arc     = true
end
