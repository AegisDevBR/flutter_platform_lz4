#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_platform_lz4.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_platform_lz4'
  s.version          = '0.0.1'
  s.summary          = 'Block LZ4 decompressing for Android and iOS using platform-specific code.'
  s.description      = <<-DESC
Block LZ4 decompressing for Android and iOS using platform-specific code.
                       DESC
  s.homepage         = 'https://github.com/AegisDevBR'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Matheus Bastos' => 'mathheusb@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
