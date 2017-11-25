Pod::Spec.new do |s|
  s.name             = 'PinCodeField'
  s.version          = '0.1.0'
  s.summary          = 'Customizable pin code control for iOS apps.'
  s.description      = <<-DESC
PinCodeField is a simple and customizable control, designed for entering PIN-codes.
                       DESC

  s.homepage         = 'https://github.com/nestorpopko/PinCodeField'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'nestorpopko' => 'nestorpopko@gmail.com' }
  s.source           = { :git => 'https://github.com/nestorpopko/PinCodeField.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'PinCodeField/Classes/**/*'

end
