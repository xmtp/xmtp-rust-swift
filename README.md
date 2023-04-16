# XMTP Rust Swift helper

Do things in Rust that are hard in Swift

## Diagram

```
┌────────────────────────────────────┬──────────────────────────────────────┬───────────────────────────────────────────────────┐
│                                    │                                      │                                                   │
│  xmtp/libxmtp: Shared Rust Code    │  xmtp/xmtp_rust_swift                │ xmtp/xmtp-ios - iOS SDK                           │
│    - xmtp-networking               │   : Swift Package hosted in Github   │  - consumes xmtp/proto but without gRPC files     │
│    - xmtp-proto                    │   + ApiService one-file Swift wrapper│  - Package.swift dep for xmtp/xmtp_rust_swift     │
│    |                               │    ┌───────────────────┐             │  ┌──────────────────┐                             │
│    ---> bindingx/xmtp_rust_swift   │ ┌─►│-Package.swift     │             │  │                  │                             │
│                                    │ │  │-XMTPRust.xcframe..│  Swift Pkg  │  │ Package.swift    │                             │
│ ┌──────────┐     ┌───────────────┐ │ │  │-Sources/...       ├─────────────┼─►│                  │                             │
│ │xmtp-proto├────►│xmtp-networking│ │ │  │ -ApiService.swift │  Github url │  │ - ApiClient.swift│                             │
│ └──────────┘     └─────┬─────────┘ │ │  └───────────────────┘             │  │  - Uses XMTPRust │                             │
│                        │           │ │                                    │  └──────────────────┘                             │
│        ┌───────────────▼────┐      │ │                                    │                                                   │
│        │libxmtp/bindings/   │      │ │                                    ├───────────────────────────────────────────────────┤
│        │  xmtp_rust_swift   │      │ │                                    │ xmtp/xmtp-react-native                            │
│        │   w/ swift-bridge  │      │ │                                    │  - consumes xmtp/xmtp-ios as a static library     │
│        └──────────┬─────────┘      │ ├────────┐                           │     or maybe a Cocoapod (requires work)           │
│                   │                │ │filecopy│                           │                                                   │
│           Output: │                │ ├────────┘                           │                                                   │
│        ┌──────────▼─────────┐      │ │                                    │                                                   │
│        │XMTPRust.xcframework├──────┼─┘                                    │                                                   │
│        └────────────────────┘      │                                      │                                                   │
│                                    │                                      │                                                   │
└────────────────────────────────────┴──────────────────────────────────────┴───────────────────────────────────────────────────┘
```
