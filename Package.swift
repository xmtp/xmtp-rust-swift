// swift-tools-version:5.3
import PackageDescription
import Foundation
let package = Package(
        name: "XMTPRust",
        platforms: [
            .iOS(.v13), 
            .macOS(.v11)
        ],
        products: [
            .library(
                name: "XMTPRust",
                targets: ["XMTPRust", "XMTPRustSwift", "Bridge"]),
        ],
        targets: [
            .target(
                name: "XMTPRust",
                dependencies: ["Bridge"],
                linkerSettings: [
                    .linkedFramework("XMTPRustSwift", .when(platforms: [.iOS, .macOS]))
                ]),
            .target(
                name: "Bridge",
                dependencies: ["XMTPRustSwift"],
                path: "Sources/Bridge"),
            .binaryTarget(
                name: "XMTPRustSwift",
                path: "XMTPRustSwift.xcframework"),
        ]
)
