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
                targets: ["XMTPRust", "XMTPRustSwift"]),
        ],
        targets: [
            .target(
                name: "XMTPRust",
                dependencies: ["XMTPRustSwift"],
                path: "Sources/XMTPRust"
            ),
            .binaryTarget(
                name: "XMTPRustSwift",
                path: "XMTPRustSwift.xcframework"),
            .testTarget(
                name: "XMTPRust-Tests",
                dependencies: ["XMTPRust"],
                path: "Tests/XMTPRust-Tests")
        ]
)
