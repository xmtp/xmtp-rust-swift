#include "bridge.h"

// Dummy target to import the bridging headers
// https://forums.swift.org/t/swift-package-and-xcframework-target-for-c-library-where-to-include-the-header/51163/3

void __dummy() {
    __swift_bridge__$ResponseJson test;
}
