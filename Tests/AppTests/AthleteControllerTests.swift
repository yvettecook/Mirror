import XCTest
import Testing
import HTTP
import Sockets
@testable import Vapor
@testable import App

class AthleteControllerTests: TestCase {

    static let allTests = [
        ("testFetchRoutes", testFetchRoutes)
    ]

    let drop = try! Droplet.testable()
    var port: Sockets.Port!

    func testFetchRoutes() throws {
        port = drop.config["server.port"]?.int?.port ?? 8080

        try fetchYvette()
    }

    func fetchYvette() throws {
        let req = Request.makeTest(method: .get, port: port, path: "/athlete/1210219")
        let res = try drop.testResponse(to: req)

        let json = res.json
        XCTAssertNotNil(json)
    }
}
