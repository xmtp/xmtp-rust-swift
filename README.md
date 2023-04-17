# XMTP Rust Swift helper

Do things in Rust that are hard in Swift

## Diagram

```
┌────────────────────────────────────┬─────────────────────────────┬─────────────────────────────────┐
│                                    │                             │                                 │
│  xmtp/libxmtp: Shared Rust Code    │  xmtp/xmtp_rust_swift       │xmtp/xmtp-ios - iOS SDK          │
│    - xmtp-networking               │  - Git repo to host Swift   │- Existing iOS xmtp SDK          │
│    - xmtp-proto                    │  Package                    │- Add xmtp_rust_swift as Swift   │
│    |                               │  - ApiService.swift is      │ package dep via Github url      │
│    ---> bindingx/xmtp_rust_swift   │  thin wrapper of XMTPRust   │- Consumes xmtp/proto on branch  │
│                                    │    ┌───────────────────┐    │   without gRPC Swift files      │
│ ┌──────────┐     ┌───────────────┐ │ ┌─►│-Package.swift     │    │- Key: no more GRPC dep!         │
│ │xmtp-proto├────►│xmtp-networking│ │ │  │-XMTPRust.xcframe..│    │    ┌──────────────────┐         │
│ └──────────┘     └─────┬─────────┘ │ │  │-Sources/...       │    │    │                  │         │
│                        │           │ │  │ -ApiService.swift │    │    │ Package.swift    │         │
│        ┌───────────────▼────┐      │ │  └─────────┬─────────┘    │ ┌──►                  │         │
│        │libxmtp/bindings/   │      │ │            │  Swift Pkg   │ │  │ - ApiClient.swift│         │
│        │  xmtp_rust_swift   │      │ │            └──────────────┼─┘  │  - Uses XMTPRust │         │
│        │   w/ swift-bridge  │      │ │               Github url  │    └────────┬─────────┘         │
│        └──────────┬─────────┘      │ ├────────┐                  │             │                   │
│                   │                │ │filecopy│                  ├─────────────▼───────────────────┤
│           Output: │                │ ├────────┘                  │xmtp/xmtp-react-native           │
│        ┌──────────▼─────────┐      │ │                           │ - consumes xmtp/xmtp-ios        │
│        │XMTPRust.xcframework├──────┼─┘                           │ either as a fat static library  │
│        └────────────────────┘      │                             │ or as a Cocoapod (more work)    │
│                                    │                             │                                 │
└────────────────────────────────────┴─────────────────────────────┴─────────────────────────────────┘
```

## Releases

**NOTE**: No release is considered ready for any external consumption. This repository is very WIP.

- 0.1.0 - First release of Swift Package with publish/query working
- 0.1.1 - First attempted release of dual Swift Package and Cocoapod compatible repo
