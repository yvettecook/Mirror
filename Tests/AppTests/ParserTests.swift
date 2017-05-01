import XCTest
import Testing
@testable import Vapor
@testable import App

class PostControllerTests: TestCase {

    static let allTests = [
        ("testParser", testParser)
    ]

    func testParser() throws {
        try parseAthleteName()
    }

    func parseAthleteName() {
        
    }
}
