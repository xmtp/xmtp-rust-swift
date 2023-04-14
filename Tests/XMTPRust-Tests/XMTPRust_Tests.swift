// Test file for XMTPRust target
import XMTPRust

import XCTest

// See if we can use the XMTPRust library
class XMTPRust_Tests: XCTestCase {
    func testExample() async throws {
        let apiservice = XMTPRust.ApiService(environment: "http://localhost:15555", secure: false)
        let queryResult = try await apiservice.query(topic: "test", json_paging_info: "")
        XCTAssertFalse(queryResult.isEmpty)
    }
}
