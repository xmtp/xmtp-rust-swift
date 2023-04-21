// Test file for XMTPRust target
import XMTPRust

import XCTest

// See if we can use the XMTPRust library
class XMTPRust_Tests: XCTestCase {
    func testSha256() async throws {
        let digestRustVec = XMTPRust.sha256(RustVec<UInt8>())
        var bytes: [UInt8] = []
        for byte in digestRustVec {
            bytes.append(byte)
        }
        
        let digest = Data(bytes)
        let expected = Data([
            0xe3, 0xb0, 0xc4, 0x42, 0x98, 0xfc, 0x1c, 0x14, 0x9a, 0xfb, 0xf4, 0xc8, 0x99, 0x6f,
            0xb9, 0x24, 0x27, 0xae, 0x41, 0xe4, 0x64, 0x9b, 0x93, 0x4c, 0xa4, 0x95, 0x99, 0x1b,
            0x78, 0x52, 0xb8, 0x55,
        ]);


        XCTAssertEqual(digest, expected)
    }
}
