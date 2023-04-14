// Test file for XMTPRust target
import XMTPRust

import XCTest

// See if we can use the XMTPRust library
class XMTPRust_Tests: XCTestCase {
    func testExample() async {
        let queryResult = await XMTPRust.query_topic("hello")
        assert(queryResult.error.toString().isEmpty)
    }
}
