Pod::Spec.new do |s|
  s.name             = 'XMTPRust'
  s.version          = '0.1.0'
  s.summary          = 'XMTP shared Rust code that powers cross-platform SDKs'

  s.homepage         = 'https://github.com/xmtp/xmtp-rust-swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michael Xu' => 'michaelx@xmtp.com' }
  s.source           = { :git => 'https://github.com/xmtp/xmtp-rust-swift.git', :tag => s.version.to_s }

  s.platform         = :ios, '13.0'
  s.platform         = :macos, '11.0'
  s.swift_version    = '5.3'

  s.vendored_frameworks = 'XMTPRustSwift.xcframework'

  s.source_files = 'Sources/XMTPRust/**/*'
  s.test_spec 'UnitTests' do |test_spec|
    test_spec.source_files = 'Tests/XMTPRust-Tests/**/*'
  end
end
