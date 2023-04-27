# XMTP Rust Swift

Swift Package and Cocoapod that wraps an XCFramework emitted by the `bindings/xmtp_rust_swift` crate in [libxmtp](https://github.com/xmtp/libxmtp)

## Usage

**NOTE**: This package is NOT meant to be directly consumed by end users. Instead see [xmtp-ios](https://github.com/xmtp/xmtp-ios) which depends upon this package.

### For testing purposes

Reference in Package.swift:
```
...
.package(url: "https://github.com/xmtp/xmtp-rust-swift", from: "0.2.0-beta0")
...
```
Reference in Podspec:
```
...
spec.dependency 'XMTPRust', '= 0.2.0-beta0'
...
```

## Diagram

```
┌────────────────────────────────────┬─────────────────────────────┬─────────────────────────────────┐
│                                    │                             │                                 │
│  xmtp/libxmtp: Shared Rust Code    │  xmtp/xmtp-rust-swift       │ xmtp/xmtp-ios - iOS SDK         │
│    - xmtp-networking               │  - Git repo to host Swift   │ - Existing iOS xmtp SDK         │
│    - xmtp-proto                    │  Package                    │ - Consumes xmtp-rust-swift as   │
│    |                               │  - Also contains Podspec    │ a Cocoapod via spec.dependency  │
│    ---> bindingx/xmtp_rust_swift   │  for XMTPRust pod           │                                 │
│                                    │    ┌──────────────────────┐ │                                 │
│ ┌──────────┐     ┌───────────────┐ │ ┌─►│-Package.swift        │ │                                 │
│ │xmtp-proto├────►│xmtp-networking│ │ │  │-XMTPRustSwift.xcfra..│ │    ┌──────────────────┐         │
│ └──────────┘     └─────┬─────────┘ │ │  │-Sources/...          │ │    │ XMTP.podspec     │         │
│                        │           │ │  │ - [Generated files]  │ │    │ Package.swift    │         │
│        ┌───────────────▼────┐      │ │  └─────────┬────────────┘ │ ┌──► -                │         │
│        │libxmtp/bindings/   │      │ │            │  Swift Pkg   │ │  │ import XMTPRust  │         │
│        │  xmtp_rust_swift   │      │ │            └──────────────┼─┘  │                  │         │
│        │   w/ swift-bridge  │      │ │               Github url  │    └────────┬─────────┘         │
│        └──────────┬─────────┘      │ ├────────┐      or Cocoapod │             │                   │
│                   │                │ │filecopy│                  ├─────────────▼───────────────────┤
│           Output: │                │ ├────────┘                  │xmtp/xmtp-react-native           │
│  ┌────────────────▼─────────┐      │ │                           │ - consumes xmtp/xmtp-ios        │
│  │XMTPRustSwift.xcframework ├──────┼─┘                           │ as a Cocoapod                   │
│  └──────────────────────────┘      │                             │                                 │
│                                    │                             │                                 │
└────────────────────────────────────┴─────────────────────────────┴─────────────────────────────────┘
```

## Releases

**NOTE**: No release is considered ready for any external consumption. This repository is very WIP.

- 0.2.2-beta0 - Fix bug in QueryResponse where any accessor call would cause it to be freed. Remove .swift files from include/ dirs.
- 0.2.1-beta0 - Fixes a bug where RustString was not implementing NSError correctly.
- 0.2.0-beta0 - First non-JSON binding version of 0.1.2-beta0, breaks API that xmtp-ios uses but no major bump because still prerelease.
- 0.1.2-beta0 - First release of Cocoapod and Swift Package which replaces dependencies in xmtp-ios that prevent xmtp-ios Cocoapod packaging
- 0.1.0 - First release of Swift Package with publish/query working
- 0.1.1 - First attempted release of dual Swift Package and Cocoapod compatible repo
